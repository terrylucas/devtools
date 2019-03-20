// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';

import '../framework/framework.dart';
import '../globals.dart';
import '../tables.dart';
import '../ui/custom.dart';
import '../ui/elements.dart';
import '../ui/icons.dart';
import '../ui/primer.dart';
import '../utils.dart';

import 'memory_chart.dart';
import 'memory_controller.dart';
import 'memory_detail.dart';
import 'memory_protocol.dart';

class MemoryScreen extends Screen with SetStateMixin {
  MemoryScreen()
      : super(name: 'Memory', id: 'memory', iconClass: 'octicon-package') {
    classCountStatus = StatusItem();
    addStatusItem(classCountStatus);

    objectCountStatus = StatusItem();
    addStatusItem(objectCountStatus);
  }

  final MemoryController memoryController = MemoryController();

  StatusItem classCountStatus;
  StatusItem objectCountStatus;

  PButton pauseButton;
  PButton resumeButton;

  PButton vmMemorySnapshotButton;
  PButton resetAccumulatorsButton;
  PButton filterLibrariesButton;
  PButton gcNowButton;

  ListQueue<Table<Object>> tableStack = ListQueue<Table<Object>>();
  MemoryChart memoryChart;
  CoreElement tableContainer;

  MemoryTracker memoryTracker;
  ProgressElement progressElement;

  @override
  void entering() {
    _updateListeningState();
  }

  void updateResumeButton({@required bool disabled}) {
    resumeButton.disabled = disabled;
  }

  void updatePauseButton({@required bool disabled}) {
    pauseButton.disabled = disabled;
  }

  @override
  CoreElement createContent(Framework framework) {
    final CoreElement screenDiv = div(c: 'custom-scrollbar')..layoutVertical();

    resumeButton = PButton.icon('Resume', FlutterIcons.resume_white_disabled_2x)
      ..primary()
      ..small()
      ..disabled = true;

    pauseButton = PButton.icon('Pause', FlutterIcons.pause_black_2x)..small();

    // TODO(terry): Need to correctly handle enabled and disabled.
    vmMemorySnapshotButton = PButton.icon('Snapshot', FlutterIcons.snapshot,
        title: 'Memory Snapshot')
      ..clazz('margin-left')
      ..small()
      ..click(_loadAllocationProfile)
      ..disabled = true;
    resetAccumulatorsButton = PButton.icon(
        'Reset', FlutterIcons.resetAccumulators,
        title: 'Reset Accumulators')
      ..small()
      ..click(_resetAllocatorCounts)
      ..disabled = true;
    filterLibrariesButton =
        PButton.icon('Filter', FlutterIcons.filter, title: 'Filter')
          ..small()
          ..disabled = true;
    gcNowButton =
        PButton.icon('GC', FlutterIcons.gcNow, title: 'Manual Garbage Collect')
          ..small()
          ..click(_gcNow)
          ..disabled = true;

    resumeButton.click(() {
      updateResumeButton(disabled: true);
      updatePauseButton(disabled: false);

      memoryChart.resume();
    });

    pauseButton.click(() {
      updatePauseButton(disabled: true);
      updateResumeButton(disabled: false);

      memoryChart.pause();
    });

    screenDiv.add(<CoreElement>[
      div(c: 'section')
        ..add(<CoreElement>[
          form()
            ..layoutHorizontal()
            ..clazz('align-items-center')
            ..add(<CoreElement>[
              div(c: 'btn-group flex-no-wrap')
                ..add(<CoreElement>[
                  pauseButton,
                  resumeButton,
                ]),
              div()..flex(),
              div(c: 'btn-group flex-no-wrap margin-left')
                ..add(<CoreElement>[
                  vmMemorySnapshotButton,
                  resetAccumulatorsButton,
                  filterLibrariesButton,
                  gcNowButton,
                ]),
            ]),
        ]),
      memoryChart = MemoryChart(memoryController)..disabled = true,
      tableContainer = div(c: 'section overflow-auto')
        ..layoutHorizontal()
        ..flex(),
    ]);

    memoryController.onDisconnect.listen((__) {
      serviceDisconnet();
    });

    _pushNextTable(null, _createHeapStatsTableView());

    _updateStatus(null);

    return screenDiv;
  }

  void _pushNextTable(Table<dynamic> current, Table<dynamic> next) {
    // Remove any tables to the right of current from the DOM and the stack.
    while (tableStack.length > 1 && tableStack.last != current) {
      tableStack.removeLast()
        ..element.element.remove()
        ..dispose();
    }

    // Push the new table on to the stack and to the right of current.
    if (next != null) {
      final bool isFirst = tableStack.isEmpty;

      tableStack.addLast(next);
      tableContainer.add(next.element);

      if (!isFirst) {
        next.element.clazz('margin-left');
      }

      tableContainer.element.scrollTo(<String, dynamic>{
        'left': tableContainer.element.scrollWidth,
        'top': 0,
        'behavior': 'smooth',
      });
    }
  }

  Future<void> _resetAllocatorCounts() async {
    memoryChart.plotReset();

    resetAccumulatorsButton.disabled = true;
    tableStack.first.element.display = null;
    final Spinner spinner =
        tableStack.first.element.add(Spinner()..clazz('padded'));

    try {
      final List<ClassHeapDetailStats> heapStats =
          await memoryController.resetAllocationProfile();
      tableStack.first.setRows(heapStats);
      _updateStatus(heapStats);
      spinner.element.remove();
    } catch (e) {
      framework.toast('Reset failed ${e.toString()}', title: 'Error');
    } finally {
      resetAccumulatorsButton.disabled = false;
    }
  }

  Future<void> _loadAllocationProfile({bool reset = false}) async {
    memoryChart.plotSnapshot();

    vmMemorySnapshotButton.disabled = true;
    tableStack.first.element.display = null;
    final Spinner spinner =
        tableStack.first.element.add(Spinner()..clazz('padded'));

    try {
      final List<ClassHeapDetailStats> heapStats =
          await memoryController.getAllocationProfile();
      tableStack.first.setRows(heapStats);
      _updateStatus(heapStats);
      spinner.element.remove();
    } catch (e) {
      framework.toast('Snapshot failed ${e.toString()}', title: 'Error');
    } finally {
      vmMemorySnapshotButton.disabled = false;
    }
  }

  Future<Null> _gcNow() async {
    gcNowButton.disabled = true;

    try {
      await memoryController.gc();
    } catch (e) {
      framework.toast('Unable to GC ${e.toString()}', title: 'Error');
    } finally {
      gcNowButton.disabled = false;
    }
  }

  void _updateListeningState() async {
    await serviceManager.serviceAvailable.future;

    final bool shouldBeRunning = isCurrentScreen;

    if (shouldBeRunning && !memoryController.hasStarted) {
      await memoryController.startTimeline();

      pauseButton.disabled = false;
      resumeButton.disabled = true;

      vmMemorySnapshotButton.disabled = false;
      resetAccumulatorsButton.disabled = false;
      gcNowButton.disabled = false;

      memoryChart.disabled = false;
    }
  }

  // VM Service has stopped (disconnected).
  void serviceDisconnet() {
    pauseButton.disabled = true;
    resumeButton.disabled = true;

    vmMemorySnapshotButton.disabled = true;
    resetAccumulatorsButton.disabled = true;
    filterLibrariesButton.disabled = true;
    gcNowButton.disabled = true;

    memoryChart.disabled = true;
  }

  Table<ClassHeapDetailStats> _createHeapStatsTableView() {
    final Table<ClassHeapDetailStats> table =
        Table<ClassHeapDetailStats>.virtual()
          ..element.display = 'none'
          ..element.clazz('memory-table');

    table.addColumn(MemoryColumnSize());
    table.addColumn(MemoryColumnInstanceCount());
    table.addColumn(MemoryColumnInstanceAccumulatedCount());
    table.addColumn(MemoryColumnClassName());

    table.setSortColumn(table.columns.first);

    table.onSelect.listen((ClassHeapDetailStats row) async {
      final Table<InstanceSummary> newTable =
          row == null ? null : await _createInstanceListTableView(row);
      _pushNextTable(table, newTable);
    });

    return table;
  }

  Future<Table<InstanceSummary>> _createInstanceListTableView(
      ClassHeapDetailStats row) async {
    final Table<InstanceSummary> table = new Table<InstanceSummary>.virtual()
      ..element.clazz('memory-table');

    try {
      final List<InstanceSummary> instanceRows = await memoryController
          .getInstances(row.classRef.id, row.instancesCurrent);

      table.addColumn(new MemoryColumnSimple<InstanceSummary>(
          '${instanceRows.length} Instances of ${row.classRef.name}',
          (InstanceSummary row) => row.objectRef));

      table.setRows(instanceRows);
    } catch (e) {
      framework.toast('Problem fetching instances $e', title: 'Error');
    }

    return table;
  }

  void _updateStatus(List<ClassHeapDetailStats> data) {
    if (data == null) {
      classCountStatus.element.text = '';
      objectCountStatus.element.text = '';
    } else {
      classCountStatus.element.text = '${nf.format(data.length)} classes';
      int objectCount = 0;
      for (ClassHeapDetailStats stats in data) {
        objectCount += stats.instancesCurrent;
      }
      objectCountStatus.element.text = '${nf.format(objectCount)} objects';
    }
  }
}
