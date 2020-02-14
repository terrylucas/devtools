// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@TestOn('vm')

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:devtools_app/src/inspector/flutter_widget.dart';
import 'package:devtools_app/src/ui/fake_flutter/fake_flutter.dart';
import 'package:devtools_app/src/flutter/app.dart';
import 'package:devtools_app/src/framework/framework_core.dart';
import 'package:devtools_app/src/inspector/flutter_widget.dart';
import 'package:devtools_app/src/ui/fake_flutter/fake_flutter.dart';
import 'package:devtools_shared/devtools_shared.dart';
import 'package:devtools_testing/support/file_utils.dart';
import 'package:devtools_testing/support/flutter_test_driver.dart';
import 'package:devtools_testing/support/flutter_test_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;

Future<void> main() async {
  // TODO(terry): Should work on Windows too need to test.
  if (Platform.isLinux || Platform.isMacOS)
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  // This integration test can only be run with LiveWidgetsFlutterBinding.
  // This test cannot be run as a flutter driver test instead because of
  // https://github.com/flutter/flutter/issues/49843 (Chrome),
  // https://github.com/flutter/flutter/issues/49841 (Mac),
  // (Nor on Linux either).

  TestWidgetsFlutterBinding.ensureInitialized({'FLUTTER_TEST': 'false'});
  HttpOverrides.global = null;
  assert(
      WidgetsBinding.instance is LiveTestWidgetsFlutterBinding,
      'The integration tests must run with a LiveWidgetsBinding.\n'
      'These tests make real async calls that cannot be wrapped in a\n'
      'FakeAsync zone.\n'
      'The current binding is ${WidgetsBinding.instance}.\n'
      '\n'
      'You can likely fix this by running the test on platform vm with\n'
      '`flutter run` instead of `flutter test`\n');
  final FlutterTestEnvironment env = FlutterTestEnvironment(
    const FlutterRunConfiguration(withDebugger: true),
  );
  compensateForFlutterTestDirectoryBug();
  Catalog.setCatalog(Catalog.decode(await widgetsJson()));

  group('Whole app', () {
    testWidgets('connects to a dart app', (tester) async {
      FrameworkCore.init('');
      final app = DefaultAssetBundle(
        bundle: _DiskAssetBundle(),
        child: DevToolsApp(),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await env.setupEnvironment();

      var vmUri = env.flutter.vmServiceUri.replace(scheme: 'http').toString();
      vmUri =
          vmUri.endsWith('/ws') ? vmUri.substring(0, vmUri.length - 2) : vmUri;

      try {
        final Process process = await Process.start(
          'dart',
          [
            '../devtools/bin/devtools.dart',
            '--vm-uri',
            '$vmUri',
            '--profile-memory',
            '${ParseStdout.jsonFilename}',
            '--verbose',
          ],
          workingDirectory: Directory.current.path,
        );

        // Record the verbose output so we can later validate the JSON file
        // content matches the values displayed in the verbose messages.
        final parseOutput = ParseStdout();

        process.stdout.transform(utf8.decoder).listen(parseOutput.parseStdout);
        process.stderr.transform(utf8.decoder).listen(parseOutput.parseStderr);

        // Collect some memory statistics.
        Future.delayed(const Duration(seconds: 5), () async {
          // We've collected enough - stop the test.
          Process.killPid(process.pid, ProcessSignal.sigkill);
        });

        final exitCode = await process.exitCode;
        expect(exitCode, -9); // sigkill returns a -9 exitCode.

        // Any errors received is a failure of this test.
        expect(
          parseOutput.errors.isEmpty,
          isTrue,
          reason: parseOutput.errors.toString(),
        );

        // Validate the JSON file matches what verbose displayed.
        validateJSONFile(parseOutput.verboseValues);

        // Remove the generated JSON file.
        final file = File('${Directory.current.path}/${ParseStdout.jsonFilename}');
        file.deleteSync();
      } catch (e) {
        // Unexpected failure.
        expect(isFalse, e.toString());
      }

      await env.tearDownEnvironment();
      // Tests fail if target platform is overridden.
      debugDefaultTargetPlatformOverride = null;
    });

    tearDownAll(() async {
      await env.tearDownEnvironment(force: true);
    });
  });
}

void validateJSONFile(List<Verbose> values) {
  final file = File('${Directory.current.path}/${ParseStdout.jsonFilename}');
  final contents = file.readAsStringSync();

  final samples = memoryDecodeHeapSamples(contents);
  expect(samples.length, values.length);

  var samplesIndex = 0;
  for (var value in values) {
    final intl.DateFormat mFormat = intl.DateFormat('hh:mm:ss.mmm');
    final timeCollected = mFormat.format(
        DateTime.fromMillisecondsSinceEpoch(samples[samplesIndex].timestamp));

    expect(timeCollected, value.time);
    expect(samples[samplesIndex].capacity, value.capacity);
    expect(samples[samplesIndex].adbMemoryInfo.total, value.adbMemoryTotal);

    samplesIndex++;
  }
}

class Verbose {
  Verbose(this.time, this.capacity, this.adbMemoryTotal);

  final String time;
  final int capacity;
  final int adbMemoryTotal;
}

class ParseStdout {
  static const _headerTemplate = 'Recording memory profile samples to ';
  static const jsonFilename = '__memory_samples.json';

  /// Verbose messages have the following structure:
  ///     ' Collected Sample: [01:06:55.006] capacity=46810880, ADB MemoryInfo total=0';
  static const verboseMessageStart = ' Collected Sample: [';

  /// Below parts of verbose message split('='):
  /// [0] = ] capacity
  /// [1] = #####, ADB MemoryInfo total
  /// [2] = #####

  /// Entry split('=')[0]
  static const capacityStartPart = '] capacity';

  /// Entry split('=')[1]
  static const capacityValueEndPart = ', ADB MemoryInfo total';

  bool _headerMatch;

  List<Verbose> verboseValues = [];
  List<String> errors = [];

  void parseStdout(String lineOut) {
    if (_headerMatch == null && lineOut.startsWith(_headerTemplate)) {
      _headerMatch =
          lineOut.substring(_headerTemplate.length).trim() == jsonFilename;
      expect(_headerMatch, isTrue);
    } else if (lineOut.startsWith(verboseMessageStart)) {
      // Parse parts of the verbose message.

      // Pull out the timestamp part.
      final startTimePart = lineOut.substring(verboseMessageStart.length);
      final endTimePart = startTimePart.indexOf(']');
      expect(endTimePart >= 0, isTrue);
      final timePart = startTimePart.substring(0, endTimePart);

      // Pull out the two numeric values capacity and ADB Memory Total.
      final List<String> remaining =
          startTimePart.substring(endTimePart).split('=');
      expect(remaining[0], equals(capacityStartPart));

      // Capacity part.
      expect(remaining[1].endsWith(capacityValueEndPart), isTrue);
      final capacityValueEnd = remaining[1].indexOf(',');
      expect(capacityValueEnd >= 0, isTrue);
      final capacityValue =
          int.parse(remaining[1].substring(0, capacityValueEnd));

      // ADB part.
      final adbTotal = int.parse(remaining[2].trim());

      verboseValues.add(Verbose(timePart, capacityValue, adbTotal));
    }
  }

  /// Record any errors.
  void parseStderr(String lineOut) {
    errors.add(lineOut);
  }
}

class _DiskAssetBundle extends CachingAssetBundle {
  static const _assetManifestDotJson = 'AssetManifest.json';
  @override
  Future<ByteData> load(String key) async {
    if (key == _assetManifestDotJson) {
      final cache = <String, ByteData>{};
      final files = [
        ...Directory('web/').listSync(recursive: true),
        ...Directory('assets/').listSync(recursive: true),
        ...Directory('fonts/').listSync(recursive: true),
      ].where((fse) => fse is File);

      final manifest = <String, List<String>>{
        for (var file in files) file.path: [file.path]
      };

      return ByteData.view(
        Uint8List.fromList(jsonEncode(manifest).codeUnits).buffer,
      );
    }
    return ByteData.view(
      (await File('${Directory.current.path}/$key').readAsBytes()).buffer,
    );
  }
}
