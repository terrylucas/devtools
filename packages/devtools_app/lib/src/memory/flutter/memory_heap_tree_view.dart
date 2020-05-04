// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../flutter/auto_dispose_mixin.dart';
import '../../flutter/table.dart';
import '../../flutter/theme.dart';
import '../../table_data.dart';
import '../../ui/flutter/label.dart';
import '../../ui/material_icons.dart';
import '../../utils.dart';

import 'memory_controller.dart';
import 'memory_filter.dart';
import 'memory_graph_model.dart';
import 'memory_heatmap.dart';
import 'memory_snapshot_models.dart';

class HeapTree extends StatefulWidget {
  const HeapTree(
    this.controller,
  );

  final MemoryController controller;

  @override
  HeapTreeViewState createState() => HeapTreeViewState();
}

class HeapTreeViewState extends State<HeapTree> with AutoDisposeMixin {
  @visibleForTesting
  static const snapshotButtonKey = Key('Snapshot Button');
  @visibleForTesting
  static const groupByClassButtonKey = Key('Group By Class Button');
  @visibleForTesting
  static const groupByLibraryButtonKey = Key('Group By Library Button');
  @visibleForTesting
  static const collapseAllButtonKey = Key('Collapse All Button');
  @visibleForTesting
  static const expandAllButtonKey = Key('Expand All Button');
  @visibleForTesting
  static const filterButtonKey = Key('Snapshot Filter');
  @visibleForTesting
  static const searchButtonKey = Key('Snapshot Search');
  @visibleForTesting
  static const settingsButtonKey = Key('Snapshot Settings');

  MemoryController controller;

  Widget snapshotDisplay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = Provider.of<MemoryController>(context);

    cancel();

    addAutoDisposeListener(controller.selectedSnapshotNotifier, () {
      setState(() {
        controller.computeAllLibraries(true, true);
      });
    });

    addAutoDisposeListener(controller.filterNotifier, () {
      setState(() {
        controller.computeAllLibraries(true, true);
      });
    });

    addAutoDisposeListener(controller.leafSelectedNotifier, () {
      setState(() {});
    });

    addAutoDisposeListener(controller.searchNotifier, () {
      if (controller.clearSearch) {
        setState(() {
          controller.clearSearch = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the TextFieldController and FocusNode.
    searchTextFieldController.dispose();
    searchFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.snapshotByLibraryData != null) {
      if (controller.showHeatMap) {
        snapshotDisplay = HeatMapSizeAnalyzer(
          child: SizedBox.expand(
            child: FlameChart(controller),
          ),
        );
      } else {
        snapshotDisplay = MemorySnapshotTable();
      }
    } else {
      snapshotDisplay = const Text('');
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSnapshotControls(),
            _buildSearchFilterControls(),
          ],
        ),
        Expanded(
          child: buildSnapshotTables(snapshotDisplay),
        ),
      ],
    );
  }

  Widget buildSnapshotTables(Widget snapshotDisplay) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: snapshotDisplay),
          const SizedBox(width: 16.0),
          controller.isLeafSelected
              ? Expanded(child: SnapshotInstanceViewTable())
              : const Text(''),
        ],
      ),
    );
  }

  @visibleForTesting
  static const groupByMenuButtonKey = Key('Group By Menu Button');
  @visibleForTesting
  static const groupByMenuItem = Key('Filter Group By Menu Item');
  @visibleForTesting
  static const groupByKey = Key('Filter Group By');

  Widget _groupByDropdown() {
    final _groupByTypes = [
      MemoryController.groupByLibrary,
      MemoryController.groupByClass,
      MemoryController.groupByInstance,
    ].map<DropdownMenuItem<String>>(
      (
        String value,
      ) {
        return DropdownMenuItem<String>(
          key: groupByMenuItem,
          value: value,
          child: Text(
            'Group by $value',
            key: groupByKey,
          ),
        );
      },
    ).toList();

    return DropdownButton<String>(
      key: groupByMenuButtonKey,
      value: controller.groupingBy.value,
      iconSize: 20,
      style: const TextStyle(fontWeight: FontWeight.w100),
      onChanged: (String newValue) {
        setState(
          () {
            controller.selectedLeaf = null;
            controller.groupingBy.value = newValue;
            if (controller.snapshots.isNotEmpty) {
              doGroupBy();
            }
          },
        );
      },
      items: _groupByTypes,
    );
  }

  Widget _buildSnapshotControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: defaultSpacing),
          Flexible(
            child: OutlineButton(
              key: snapshotButtonKey,
              onPressed: _snapshot,
              child: Label(
                memorySnapshot,
                'Snapshot',
                minIncludeTextWidth: 200,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: Row(
              children: [
                const Text('Heat Map'),
                Switch(
                    value: controller.showHeatMap,
                    onChanged: (value) {
                      setState(() {
                        controller.showHeatMap = value;
                        controller.selectedLeaf = null;
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          controller.showHeatMap ? const Text('') : _groupByDropdown(),
          const SizedBox(width: 16.0),
          // TODO(terry): Mechanism to handle expand/collapse on both
          // tables objects/fields. Maybe notion in table?
          controller.showHeatMap
              ? const Text('')
              : OutlineButton(
                  key: collapseAllButtonKey,
                  onPressed: snapshotDisplay is MemorySnapshotTable
                      ? () {
                          if (snapshotDisplay is MemorySnapshotTable) {
                            controller.groupByTreeTable.dataRoots
                                .every((element) {
                              element.collapseCascading();
                              return true;
                            });
                            if (controller.instanceFieldsTreeTable != null) {
                              // We're collapsing close the fields table.
                              controller.selectedLeaf = null;
                            }
                            setState(() {});
                          }
                        }
                      : null,
                  child: const Text('Collapse All'),
                ),
          controller.showHeatMap
              ? const Text('')
              : OutlineButton(
                  key: expandAllButtonKey,
                  onPressed: snapshotDisplay is MemorySnapshotTable
                      ? () {
                          if (snapshotDisplay is MemorySnapshotTable) {
                            controller.groupByTreeTable.dataRoots
                                .every((element) {
                              element.expandCascading();
                              return true;
                            });
                            setState(() {});
                          }
                        }
                      : null,
                  child: const Text('Expand All'),
                ),
        ],
      ),
    );
  }

  FocusNode searchFieldFocusNode;
  TextEditingController searchTextFieldController;

  void clearSearchField() {
    if (controller.search.isNotEmpty) {
      controller.clearSearch = true;
      searchTextFieldController.clear();
      controller.search = '';
    }
  }

  TextField createSearchField() {
    // Creating new TextEditingController.
    searchFieldFocusNode = FocusNode();
    searchTextFieldController = TextEditingController();

    final searchField = TextField(
      autofocus: true,
      enabled: controller.showHeatMap && controller.snapshots.isNotEmpty,
      focusNode: searchFieldFocusNode,
      controller: searchTextFieldController,
      onChanged: (value) {
        if (controller.showHeatMap) {
          controller.search = value;
        }
      },
      onEditingComplete: () {
        searchFieldFocusNode.requestFocus();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        border: const OutlineInputBorder(),
        labelText: 'Search',
        hintText: 'Search',
        suffix: IconButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: () {
            clearSearchField();
          },
          icon: const Icon(Icons.clear, size: 16),
        ),
      ),
    );

    if (controller.showHeatMap && controller.snapshots.isNotEmpty) {
      searchFieldFocusNode.requestFocus();
    }

    return searchField;
  }

  Widget _buildSearchFilterControls() {
    final searchAndRawKeyboard = controller.showHeatMap
        ? RawKeyboardListener(
            child: createSearchField(),
            focusNode: FocusNode(),
            onKey: (RawKeyEvent event) {
              if (event is RawKeyDownEvent) {
                if (event.logicalKey.keyId == LogicalKeyboardKey.escape.keyId) {
                  // ESCAPE key pressed clear search TextField.
                  clearSearchField();
                }
              }
            },
          )
        : const Text('');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 300.0,
            height: 40.0,
            child: searchAndRawKeyboard,
          ),
          const SizedBox(width: 16.0),
          Flexible(
            child: OutlineButton(
              key: filterButtonKey,
              onPressed: _filter,
              child: Label(
                filterIcon,
                'Filter',
                minIncludeTextWidth: 200,
              ),
            ),
          ),
          Flexible(
            child: OutlineButton(
              key: settingsButtonKey,
              onPressed: _settings,
              child: Label(
                settings,
                'Settings',
                minIncludeTextWidth: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _snapshot() async {
    final snapshotTimestamp = DateTime.now();

    final graph = await controller.snapshotMemory();
    final snapshotCollectionTime = DateTime.now();

    // To debug particular classes add their names to the last
    // parameter classNamesToMonitor e.g., ['AppStateModel', 'Terry', 'TerryEntry']
    controller.heapGraph = convertHeapGraph(
      controller,
      graph,
      [],
    );
    final snapshotGraphTime = DateTime.now();

    controller.storeSnapshot(snapshotTimestamp, graph);

    await doGroupBy();
    controller.computeAllLibraries();
    final snapshotDoneTime = DateTime.now();

    controller.selectedSnapshotTimestamp =
        DateFormat('dd-MMM-yyyy@H:m.s').format(snapshotTimestamp);

    print('Total Snapshot completed in'
        ' ${snapshotDoneTime.difference(snapshotTimestamp).inMilliseconds / 1000} seconds');
    print('  Snapshot collected in'
        ' ${snapshotCollectionTime.difference(snapshotTimestamp).inMilliseconds / 1000} seconds');
    print('  Snapshot graph built in'
        ' ${snapshotGraphTime.difference(snapshotCollectionTime).inMilliseconds / 1000} seconds');
    print('  Snapshot grouping/libraries computed in'
        ' ${snapshotDoneTime.difference(snapshotGraphTime).inMilliseconds / 1000} seconds');
  }

  Future<void> doGroupBy() async {
    controller.heapGraph.computeInstancesForClasses();
    controller.heapGraph.computeRawGroups();
    controller.heapGraph.computeFilteredGroups();
  }

  // TODO(terry): Need to add external heap to snapshot table.
  /*
                print("Total size of external Heap ${graph.externalSize}");
                int externalSize = graph.externalProperties.length;
                for (var index = 0; index < externalSize; index++) {
                  final externalProperty = graph.externalProperties[index];
                  print("[$index] name=${externalProperty.name} size=${externalProperty.externalSize}");
                }
                */

  void dumpClassGroupBySingleLine(
      Map<String, List<HeapGraphElementActual>> classGroup) {
    print('========== Class by Instance ==========');
    classGroup.forEach((key, instances) {
      final shallowSizes = instances.first.theClass.instancesTotalShallowSizes;
      final count = instances.length;
      print('Class $key instances=[$count] totalShallowSize=$shallowSizes:');
    });
  }

  void dumpLibraryGroupBySingleLine(
      Map<String, List<HeapGraphClassActual>> libraryGroup) {
    print('========== Library by Class ==========');
    libraryGroup.forEach((libraryKey, libraryClasses) {
      print('Library $libraryKey:');
      for (var actualClass in libraryClasses) {
        final instances = actualClass.getInstances(controller.heapGraph);
        final shallowSizes = instances.isEmpty
            ? 0
            : instances.first.theClass.instancesTotalShallowSizes;
        print(
            '   class ${actualClass.name} instances count=${instances.length} shallow size=$shallowSizes');
      }
    });
  }

  void _filter() {
    showDialog(
      context: context,
      builder: (BuildContext context) => SnapshotFilterDialog(controller),
    );
  }

  void _settings() {
    // TODO(terry): TBD
  }
}

class SnapshotInstanceViewTable extends StatefulWidget {
  @override
  SnapshotInstanceViewState createState() => SnapshotInstanceViewState();
}

/// Table of the fields of an instance (type, name and value).
class SnapshotInstanceViewState extends State<SnapshotInstanceViewTable>
    with AutoDisposeMixin {
  MemoryController controller;

  final TreeColumnData<FieldReference> treeColumn = _FieldTypeColumn();
  final List<ColumnData<FieldReference>> columns = [];

  @override
  void initState() {
    setupColumns();

    super.initState();
  }

  List<FieldReference> computeRoot() {
    final root = instanceToFieldNodes(controller, controller.selectedLeaf);
    return root.isNotEmpty ? root : [FieldReference.empty];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = Provider.of<MemoryController>(context);

    cancel();

    // Update the chart when the memorySource changes.
    addAutoDisposeListener(controller.selectedSnapshotNotifier, () {
      setState(() {
        controller.computeAllLibraries(true, true);
      });
    });

    addAutoDisposeListener(controller.leafSelectedNotifier, () {
      setState(() {});
    });
  }

  void setupColumns() {
    columns.addAll([
      treeColumn,
      _FieldNameColumn(),
      _FieldValueColumn(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    controller.instanceFieldsTreeTable = TreeTable<FieldReference>(
      dataRoots: computeRoot(),
      columns: columns,
      treeColumn: treeColumn,
      keyFactory: (typeRef) => PageStorageKey<String>(typeRef.name),
      sortColumn: columns[0],
      sortDirection: SortDirection.ascending,
    );

    return controller.instanceFieldsTreeTable;
  }
}

class _FieldTypeColumn extends TreeColumnData<FieldReference> {
  _FieldTypeColumn() : super('Type');

  @override
  dynamic getValue(FieldReference dataObject) =>
      dataObject.isEmptyReference || dataObject.isSentinelReference
          ? ''
          : dataObject.type;

  @override
  String getDisplayValue(FieldReference dataObject) =>
      '${getValue(dataObject)}';

  @override
  bool get supportsSorting => true;

  @override
  int compare(FieldReference a, FieldReference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 250.0;
}

class _FieldNameColumn extends ColumnData<FieldReference> {
  _FieldNameColumn() : super('Name');

  @override
  dynamic getValue(FieldReference dataObject) =>
      dataObject.isEmptyReference ? '' : dataObject.name;

  @override
  String getDisplayValue(FieldReference dataObject) =>
      '${getValue(dataObject)}';

  @override
  bool get supportsSorting => true;

  @override
  int compare(FieldReference a, FieldReference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 150.0;
}

class _FieldValueColumn extends ColumnData<FieldReference> {
  _FieldValueColumn() : super('Value');

  @override
  dynamic getValue(FieldReference dataObject) =>
      dataObject.isEmptyReference || dataObject.isSentinelReference
          ? ''
          : dataObject.value;

  @override
  String getDisplayValue(FieldReference dataObject) {
    if (dataObject is ObjectFieldReference && !dataObject.isNull) {
      // Real object that isn't Null value is empty string.
      return '';
    }

    var value = getValue(dataObject);
    if (value is String && value.length > 30) {
      value = '${value.substring(0, 13)}…${value.substring(value.length - 17)}';
    }
    return '$value';
  }

  @override
  bool get supportsSorting => true;

  @override
  int compare(FieldReference a, FieldReference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 250.0;
}

/// Snapshot TreeTable

class MemorySnapshotTable extends StatefulWidget {
  @override
  MemorySnapshotTableState createState() => MemorySnapshotTableState();
}

/// A table of the Memory graph class top-down call tree.
class MemorySnapshotTableState extends State<MemorySnapshotTable>
    with AutoDisposeMixin {
  MemoryController controller;

  final TreeColumnData<Reference> treeColumn = _LibraryRefColumn();
  final List<ColumnData<Reference>> columns = [];

  @override
  void initState() {
    setupColumns();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = Provider.of<MemoryController>(context);

    cancel();

    // Update the chart when the memorySource changes.
    addAutoDisposeListener(controller.selectedSnapshotNotifier, () {
      setState(() {
        controller.computeAllLibraries(true, true);
      });
    });
    addAutoDisposeListener(controller.filterNotifier, () {
      setState(() {
        controller.computeAllLibraries(true, true);
      });
    });
  }

  void setupColumns() {
    columns.addAll([
      treeColumn,
      _ClassOrInstanceCountColumn(),
      _ShallowSizeColumn(),
      _RetainedSizeColumn(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    LibraryReference root = controller.computeAllLibraries();
    if (controller.groupingBy.value == MemoryController.groupByClass) {
      root = controller.classRoot;
    }

    controller.groupByTreeTable = TreeTable<Reference>(
      dataRoots: root.children,
      columns: columns,
      treeColumn: treeColumn,
      keyFactory: (libRef) => PageStorageKey<String>(libRef.name),
      sortColumn: columns[0],
      sortDirection: SortDirection.ascending,
    );

    return controller.groupByTreeTable;
  }
}

class _LibraryRefColumn extends TreeColumnData<Reference> {
  _LibraryRefColumn() : super('Library or Class');

  @override
  dynamic getValue(Reference dataObject) {
    // Should never be empty when we're displaying in table.
    assert(!dataObject.isEmptyReference);

    String value;
    if (dataObject.isLibrary) {
      value = (dataObject as LibraryReference).name;
      final splitValues = value.split('/');

      value = splitValues.length > 1
          ? '${splitValues[0]}/${splitValues[1]}'
          : splitValues[0];
    } else {
      value = dataObject.name;
    }

    return value;
  }

  @override
  String getDisplayValue(Reference dataObject) => getValue(dataObject);

  @override
  bool get supportsSorting => true;

  @override
  String getTooltip(Reference dataObject) {
    return dataObject.name;
  }

  @override
  double get fixedWidthPx => 250.0;
}

class _ClassOrInstanceCountColumn extends ColumnData<Reference> {
  _ClassOrInstanceCountColumn()
      : super('Count', alignment: ColumnAlignment.right);

  @override
  dynamic getValue(Reference dataObject) {
    assert(!dataObject.isEmptyReference);

    if (dataObject.name == MemoryController.libraryRootNode ||
        dataObject.name == MemoryController.classRootNode) return '';

    if (dataObject.isLibrary) {
      // Return number of classes.
      final libraryReference = dataObject as LibraryReference;
      return libraryReference.actualClasses.length;
    } else if (dataObject.isClass) {
      // Return number of instances.
      final classReference = dataObject as ClassReference;
      return classReference.instances.length;
    }

    return '';
  }

  @override
  String getDisplayValue(Reference dataObject) => '${getValue(dataObject)}';

  @override
  bool get supportsSorting => true;

  @override
  int compare(Reference a, Reference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 75.0;
}

class _ShallowSizeColumn extends ColumnData<Reference> {
  _ShallowSizeColumn() : super('Shallow', alignment: ColumnAlignment.right);

  int sizeAllVisibleLibraries(List<Reference> references) {
    var sum = 0;
    for (final ref in references) {
      if (ref.isLibrary) {
        final libraryReference = ref as LibraryReference;
        for (final actualClass in libraryReference.actualClasses) {
          sum += actualClass.instancesTotalShallowSizes;
        }
      }
    }
    return sum;
  }

  @override
  dynamic getValue(Reference dataObject) {
    // Should never be empty when we're displaying in table.
    assert(!dataObject.isEmptyReference);

    if (dataObject.name == MemoryController.libraryRootNode ||
        dataObject.name == MemoryController.classRootNode) {
      final snapshotGraph = dataObject.controller.snapshots.last.snapshotGraph;
      return snapshotGraph.shallowSize + snapshotGraph.externalSize;
    }

    if (dataObject.isLibrary) {
      // Return number of classes.
      final libraryReference = dataObject as LibraryReference;
      var sum = 0;
      for (final actualClass in libraryReference.actualClasses) {
        sum += actualClass.instancesTotalShallowSizes;
      }
      return sum;
    } else if (dataObject.isClass) {
      final classReference = dataObject as ClassReference;
      return classReference.actualClass.instancesTotalShallowSizes;
    } else if (dataObject.isObject) {
      // Return number of instances.
      final objectReference = dataObject as ObjectReference;
      return objectReference.instance.origin.shallowSize;
    } else if (dataObject.isFiltered) {
      final sum =
          sizeAllVisibleLibraries(dataObject.controller.libraryRoot.children);
      final snapshotGraph = dataObject.controller.snapshots.last.snapshotGraph;
      return snapshotGraph.shallowSize - sum;
    } else if (dataObject.isExternal) {
      return dataObject.controller.snapshots.last.snapshotGraph.externalSize;
    }

    return '';
  }

  @override
  String getDisplayValue(Reference dataObject) {
    final value = getValue(dataObject);

    // TODO(terry): Add percent to display too.
/*
    final total = dataObject.controller.snapshots.last.snapshotGraph.capacity;
    final percentage = (value / total) * 100;
    final displayPercentage = percentage < .050 ? '<<1%' : '${NumberFormat.compact().format(percentage)}%';
    print('$displayPercentage [${NumberFormat.compact().format(percentage)}%]');
*/
    return NumberFormat.compact().format(value);
  }

  @override
  bool get supportsSorting => true;

  @override
  int compare(Reference a, Reference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 100.0;
}

class _RetainedSizeColumn extends ColumnData<Reference> {
  _RetainedSizeColumn() : super('Retained', alignment: ColumnAlignment.right);

  @override
  dynamic getValue(Reference dataObject) {
    // Should never be empty when we're displaying in table.
    assert(!dataObject.isEmptyReference);

    if (dataObject.name == MemoryController.libraryRootNode ||
        dataObject.name == MemoryController.classRootNode) return '';

    if (dataObject.isLibrary) {
      // Return number of classes.
      final libraryReference = dataObject as LibraryReference;
      var sum = 0;
      for (final actualClass in libraryReference.actualClasses)
        sum += actualClass.instancesTotalShallowSizes;
      return sum;
    } else if (dataObject.isClass) {
      final classReference = dataObject as ClassReference;
      return classReference.actualClass.instancesTotalShallowSizes;
    } else if (dataObject.isObject) {
      // Return number of instances.
      final objectReference = dataObject as ObjectReference;
      return objectReference.instance.origin.shallowSize;
    }

    return '';
  }

  @override
  String getDisplayValue(Reference dataObject) {
    final value = getValue(dataObject);
    return '$value';
  }

  @override
  bool get supportsSorting => true;

  @override
  int compare(Reference a, Reference b) {
    final Comparable valueA = getValue(a);
    final Comparable valueB = getValue(b);
    return valueA.compareTo(valueB);
  }

  @override
  double get fixedWidthPx => 100.0;
}
