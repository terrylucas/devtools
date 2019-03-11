// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../tables.dart';

import 'memory_protocol.dart';

class MemoryRow {
  MemoryRow(this.name, this.bytes, this.percentage);

  final String name;
  final int bytes;
  final double percentage;

  @override
  String toString() => name;
}

class MemoryColumnClassName extends Column<ClassHeapStats> {
  MemoryColumnClassName() : super('Class', wide: true);

  @override
  dynamic getValue(ClassHeapStats item) => item.classRef.name;
}

class MemoryColumnSize extends Column<ClassHeapStats> {
  MemoryColumnSize() : super('Size');

  @override
  bool get numeric => true;

  //String get cssClass => 'monospace';

  @override
  dynamic getValue(ClassHeapStats item) => item.bytesCurrent;

  @override
  String render(dynamic value) {
    if (value < 1024) {
      return ' ${Column.fastIntl(value)}';
    } else {
      return ' ${Column.fastIntl(value ~/ 1024)}k';
    }
  }
}

class MemoryColumnInstanceCount extends Column<ClassHeapStats> {
  MemoryColumnInstanceCount() : super('Count');

  @override
  bool get numeric => true;

  @override
  dynamic getValue(ClassHeapStats item) => item.instancesCurrent;

  @override
  String render(dynamic value) => Column.fastIntl(value);
}

class MemoryColumnInstanceAccumulatedCount extends Column<ClassHeapStats> {
  MemoryColumnInstanceAccumulatedCount() : super('Accumulator');

  @override
  bool get numeric => true;

  @override
  dynamic getValue(ClassHeapStats item) => item.instancesAccumulated;

  @override
  String render(dynamic value) => Column.fastIntl(value);
}

class MemoryColumnSimple<T> extends Column<T> {
  MemoryColumnSimple(String name, this.getter, {bool wide = false})
      : super(name, wide: wide);

  String Function(T) getter;

  @override
  String getValue(T item) => getter(item);
}

//  void _loadHeapSnapshot() {
//    List<Event> events = [];
//    Completer<List<Event>> graphEventsCompleter = new Completer();
//    StreamSubscription sub;
//
//    int received = 0;
//    sub = serviceInfo.service.onGraphEvent.listen((Event e) {
//      int index = e.json['chunkIndex'];
//      int count = e.json['chunkCount'];
//
//      print('received $index of $count');
//
//      if (events.length != count) {
//        events.length = count;
//        progressElement.max = count;
//      }
//
//      received++;
//
//      progressElement.value = received;
//
//      events[index] = e;
//
//      if (!events.any((e) => e == null)) {
//        sub.cancel();
//        graphEventsCompleter.complete(events);
//      }
//    });
//
//    loadSnapshotButton.disabled = true;
//    progressElement.value = 0;
//    progressElement.display = 'initial';
//
//    // TODO(devoncarew): snapshot info comes in as multiple binary _Graph events
//    serviceInfo.service
//        .requestHeapSnapshot(_isolateId, 'VM', true)
//        .catchError((e) {
//      framework.showError('Error retrieving heap snapshot', e);
//    });
//
//    graphEventsCompleter.future.then((List<Event> events) {
//      print('received ${events.length} heap snapshot events.');
//      toast('Snapshot download complete.');
//
//      // type, kind, isolate, timestamp, chunkIndex, chunkCount, nodeCount, _data
//      for (Event e in events) {
//        int nodeCount = e.json['nodeCount'];
//        ByteData data = e.json['_data'];
//        print('  $nodeCount nodes, ${data.lengthInBytes ~/ 1024}k data');
//      }
//    }).whenComplete(() {
//      print('done');
//      loadSnapshotButton.disabled = false;
//      progressElement.display = 'none';
//    });
//  }
