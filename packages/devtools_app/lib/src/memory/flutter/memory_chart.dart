// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/adapter_android_mp.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_chart/mp/core/enums/legend_form.dart';
import 'package:mp_chart/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_chart/mp/core/enums/legend_orientation.dart';
import 'package:mp_chart/mp/core/enums/x_axis_position.dart';
import 'package:mp_chart/mp/core/enums/y_axis_label_position.dart';
import 'package:mp_chart/mp/core/image_loader.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import 'package:mp_chart/mp/core/value_formatter/large_value_formatter.dart';
import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';

import 'memory_controller.dart';

// TODO(terry): Remove canned data.
import 'timeseries_data.dart';

class MemoryChart extends StatefulWidget {
  const MemoryChart(this.memoryController);

  final MemoryController memoryController;

  @override
  MemoryChartState createState() => MemoryChartState();
}

class MemoryChartState extends State<MemoryChart> {
  LineChartController _chartController;
  LineChart _lineChart;

  LineChartController get chartController => _chartController;

  @override
  void initState() {
    _initController();

    // Load the data either all at once or simulating a feed (if argument is true).
    _initLineData(true);

    super.initState();
  }

  String getTitle() => 'Memory Time Series';

  @override
  Widget build(BuildContext context) {
    _lineChart = LineChart(_chartController);

    return Stack(
      children: <Widget>[
        _lineChart,
      ],
    );
  }

  var legendTypeFace =
      TypeFace(fontFamily: 'OpenSans', fontWeight: FontWeight.w100);

  void _initController() {
    final desc = Description()..enabled = false;

    _chartController = LineChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..position = YAxisLabelPosition.OUTSIDE_CHART
            ..setValueFormatter(LargeValueFormatter())
            ..drawGridLines = (true)
            ..granularityEnabled = (true)
            ..setAxisMinimum(0)
            ..textColor = const Color.fromARGB(255, 0, 0, 0);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = false;
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..position = XAxisPosition.BOTTOM
            ..textSize = 10
            ..textColor = ColorUtils.WHITE
            ..drawAxisLine = false
            ..drawGridLines = true
            ..textColor = const Color.fromARGB(255, 0, 0, 0)
            ..centerAxisLabels = true
            ..setGranularity(1)
            ..setValueFormatter(XAxisFormatter());
        },
        legendSettingFunction: (legend, controller) {
          legend.enabled = false;
          // TODO(terry): Need to support legend with a smaller text size.
          /*
           legend
            ..shape = LegendForm.LINE
            ..verticalAlignment = LegendVerticalAlignment.TOP
            ..enabled = true
            ..orientation = LegendOrientation.HORIZONTAL
            ..typeface = legendTypeFace
            ..xOffset = 20
            ..drawInside = false
            ..horizontalAlignment = LegendHorizontalAlignment.CENTER
            ..textSize = 6.0;
          */
        },
        highLightPerTapEnabled: true,
        backgroundColor: ColorUtils.WHITE,
        drawGridBackground: false,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        description: desc);

    // Compute padding around chart.
    _chartController.setViewPortOffsets(50, 10, 10, 30);
  }

  final List<Entry> _used = <Entry>[];
  final List<Entry> _capacity = <Entry>[];
  final List<Entry> _externalHeap = <Entry>[];

  var _img;

  LineDataSet usedHeapSet;
  LineDataSet capacityHeapSet;
  LineDataSet externalMemorySet;

  _loadImage() async => ImageLoader.loadImage('assets/img/star.png');

  int timerDataIndex = 0;
  Timer _timer;
  Future<void> startTimer(
    List<Entry> capacity,
    List<Entry> used,
    List<Entry> externalHeap,
  ) async {
    if (_img == null) await _loadImage();

    used.clear();
    capacity.clear();
    externalHeap.clear();

    // Prime the data.
    if (timerDataIndex < externalMemoryData.length) {
      int x;
      int y;

      x = externalMemoryData[timerDataIndex];
      y = externalMemoryData[timerDataIndex + 1];
      externalHeap.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

      x = usedHeapData[timerDataIndex];
      y = usedHeapData[timerDataIndex + 1] +
          externalMemoryData[timerDataIndex + 1];
      used.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

      x = heapCapacityData[timerDataIndex];
      y = heapCapacityData[timerDataIndex + 1];
      capacity.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

      timerDataIndex += 2;
    }

    // Average rate is ~500-600 ms?
    _timer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      // Pause pressed stop pumping out data simulating a live feed.
      if (widget.memoryController.paused) return;

      if (timerDataIndex < externalMemoryData.length) {
        int x;
        int y;

        x = externalMemoryData[timerDataIndex];
        y = externalMemoryData[timerDataIndex + 1];
        externalHeap.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

        x = usedHeapData[timerDataIndex];
        y = usedHeapData[timerDataIndex + 1] +
            externalMemoryData[timerDataIndex + 1];
        used.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

        x = heapCapacityData[timerDataIndex];
        y = heapCapacityData[timerDataIndex + 1];
        capacity.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));

        timerDataIndex += 2;

        // Signal data has changed.
        usedHeapSet.notifyDataSetChanged();
        capacityHeapSet.notifyDataSetChanged();
        externalMemorySet.notifyDataSetChanged();

        _chartController.data = LineData.fromList(
            []..add(usedHeapSet)..add(externalMemorySet)..add(capacityHeapSet));

        setState(() {});
      } else {
        _timer.cancel();
        widget.memoryController.resumeTimer();
      }
    });
  }

  Future<void> loadAllData(
    List<Entry> capacity,
    List<Entry> used,
    List<Entry> externalHeap,
  ) async {
    if (_img == null) await _loadImage();

    int index;

    index = 0;
    while (index < externalMemoryData.length) {
      final x = externalMemoryData[index];
      final y = externalMemoryData[index + 1];

      externalHeap.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));
      index += 2;
    }

    index = 0;
    while (index < usedHeapData.length) {
      final x = usedHeapData[index];
      final y = usedHeapData[index + 1] + externalMemoryData[index + 1];

      used.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));
      index += 2;
    }

    index = 0;
    while (index < heapCapacityData.length) {
      final x = heapCapacityData[index];
      final y = heapCapacityData[index + 1];

      capacity.add(Entry(x: x.toDouble(), y: y.toDouble(), icon: _img));
      index += 2;
    }
  }

  void _initLineData([bool simulateFeed = false]) async {
    if (!simulateFeed) {
      await loadAllData(_capacity, _used, _externalHeap);
    } else if (_timer == null) {
      await startTimer(_capacity, _used, _externalHeap);
    } else {
      return;
    }

    // Create heap used dataset.
    usedHeapSet = LineDataSet(_used, 'Used');
    usedHeapSet
      ..setAxisDependency(AxisDependency.LEFT)
      ..setColor1(ColorUtils.getHoloBlue())
      ..setValueTextColor(ColorUtils.getHoloBlue())
      ..setLineWidth(.7)
      ..setDrawCircles(false)
      ..setDrawValues(false)
      ..setFillAlpha(65)
      ..setFillColor(ColorUtils.getHoloBlue())
      ..setDrawCircleHole(false)
      // Fill in area under set.
      ..setDrawFilled(true)
      ..setFillColor(ColorUtils.getHoloBlue())
      ..setFillAlpha(80);

    // Create heap capacity dataset.
    capacityHeapSet = LineDataSet(_capacity, 'Capacity')
      ..setAxisDependency(AxisDependency.LEFT)
      ..setColor1(ColorUtils.GRAY)
      ..setValueTextColor(ColorUtils.GRAY)
      ..setLineWidth(.5)
      ..enableDashedLine(5, 5, 0)
      ..setDrawCircles(false)
      ..setDrawValues(false)
      ..setFillAlpha(65)
      ..setFillColor(ColorUtils.GRAY)
      ..setDrawCircleHole(false);

    // Create external memory dataset.
    const externalColorLine =
        Color.fromARGB(0xff, 0x42, 0xa5, 0xf5); // Color.blue[400]
    const externalColor =
        Color.fromARGB(0xff, 0x90, 0xca, 0xf9); // Color.blue[200]
    externalMemorySet = LineDataSet(_externalHeap, 'External');
    externalMemorySet
      ..setAxisDependency(AxisDependency.LEFT)
      ..setColor1(externalColorLine)
      ..setLineWidth(.7)
      ..setDrawCircles(false)
      ..setDrawValues(false)
      ..setHighLightColor(const Color.fromARGB(255, 244, 117, 117))
      ..setDrawCircleHole(false)
      // Fill in area under set.
      ..setDrawFilled(true)
      ..setFillColor(externalColor)
      ..setFillAlpha(190);

    // Create a data object with all the data sets.
    _chartController.data = LineData.fromList(
        []..add(usedHeapSet)..add(externalMemorySet)..add(capacityHeapSet));
    _chartController.data
      ..setValueTextColor(ColorUtils.getHoloBlue())
      ..setValueTextSize(9);

    setState(() {});
  }
}

class XAxisFormatter extends ValueFormatter {
  final intl.DateFormat mFormat = intl.DateFormat('hh:mm:ss.mmm');

  @override
  String getFormattedValue1(double value) {
    return mFormat.format(DateTime.fromMillisecondsSinceEpoch(value ~/ 1000));
  }
}
