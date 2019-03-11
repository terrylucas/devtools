// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@TestOn('vm')
import 'package:devtools/src/memory/memory_controller.dart';
import 'package:devtools/src/memory/memory_protocol.dart';

import 'package:test/test.dart';

import 'support/flutter_test_driver.dart' show FlutterRunConfiguration;
import 'support/flutter_test_environment.dart';

MemoryController memoryController;

// Track number of onMemory events received.
int memoryTrackersReceived = 0;

int previousTimestamp = 0;

void validateHeapInfo(MemoryTracker data) {
  for (final HeapSample sample in data.samples) {
    expect(sample.timestamp, greaterThan(0));
    expect(sample.timestamp, greaterThan(previousTimestamp));

    expect(sample.used, greaterThan(0));
    expect(sample.used, lessThan(sample.capacity));

    expect(sample.external, greaterThan(0));
    expect(sample.external, lessThan(sample.capacity));

    expect(sample.rss, greaterThan(0));

    expect(sample.rss, greaterThan(sample.capacity));

    expect(sample.capacity, greaterThan(0));
    expect(sample.capacity, greaterThan(sample.used + sample.external));

    previousTimestamp = sample.timestamp;
  }

  data.samples.clear();

  memoryTrackersReceived++;
}

const int defaultSampleSize = 5;

Future<void> collectSamples([int sampleCount = defaultSampleSize]) async {
  // Keep memory profiler running for n samples of heap info from the VM.
  int trackers = 0;
  while (trackers++ < sampleCount) {
    await memoryController.onMemory.first;
  }
}

void check(ClassHeapStats classStat, String className,
    {int instanceCount, int accumulatorCount}) {
  expect(classStat.classRef.name, equals(className));
  expect(classStat.instancesCurrent, equals(instanceCount));
  expect(classStat.instancesAccumulated, equals(accumulatorCount));
}

void main() async {
  final FlutterTestEnvironment env = FlutterTestEnvironment(
    const FlutterRunConfiguration(withDebugger: true),
  );

  env.afterNewSetup = () async {
    memoryController = MemoryController();
    await memoryController.startTimeline();
  };

  group('MemoryController', () {
    test('heap info', () async {
      await env.setupEnvironment();

      memoryController.onMemory.listen((MemoryTracker memoryTracker) {
        if (!memoryController.memoryTracker.hasConnection) {
          // VM Service connection has stopped - unexpected.
          fail('VM Service connection stoped unexpectantly.');
        } else {
          validateHeapInfo(memoryTracker);
        }
      });

      await collectSamples(); // Collect some data.

      expect(memoryTrackersReceived, equals(defaultSampleSize));
    });

    test('allocations', () async {
      await env.setupEnvironment();

      final List<ClassHeapStats> classStats =
          await memoryController.getAllocationProfile();

      final Iterator<ClassHeapStats> iterator = classStats.iterator;
      while (iterator.moveNext()) {
        final ClassHeapStats classStat = iterator.current;

        if (classStat.classRef.name == 'MyApp')
          check(classStat, 'MyApp', instanceCount: 1, accumulatorCount: 2);
        else if (classStat.classRef.name == 'ThemeData')
          check(classStat, 'ThemeData', instanceCount: 2, accumulatorCount: 4);
        else if (classStat.classRef.name == 'AppBar')
          check(classStat, 'AppBar', instanceCount: 1, accumulatorCount: 2);
        else if (classStat.classRef.name == 'Center')
          check(classStat, 'Center', instanceCount: 1, accumulatorCount: 2);
      }
    });

    test('reset', () async {
      await env.setupEnvironment();

      final List<ClassHeapStats> classStats =
          await memoryController.getAllocationProfile(reset: true);
      final Iterator<ClassHeapStats> iterator = classStats.iterator;
      while (iterator.moveNext()) {
        final ClassHeapStats classStat = iterator.current;

        if (classStat.classRef.name == 'MyApp')
          check(classStat, 'MyApp', instanceCount: 1, accumulatorCount: 0);
        else if (classStat.classRef.name == 'ThemeData')
          check(classStat, 'ThemeData', instanceCount: 2, accumulatorCount: 0);
        else if (classStat.classRef.name == 'AppBar')
          check(classStat, 'AppBar', instanceCount: 1, accumulatorCount: 0);
        else if (classStat.classRef.name == 'Center')
          check(classStat, 'Center', instanceCount: 1, accumulatorCount: 0);
      }
    });
  }, tags: 'useFlutterSdk');
}
