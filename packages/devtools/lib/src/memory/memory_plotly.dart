// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:js/js_util.dart';

import '../ui/fake_flutter/dart_ui/dart_ui.dart';
import '../ui/flutter_html_shim.dart';
import '../ui/plotly.dart';
import '../ui/theme.dart';

import 'memory_chart.dart';

import 'dart:developer';

class MemoryPlotly {
  MemoryPlotly(this._domName, this._memoryChart);

  static const String fontFamily = 'sans-serif';

  final String _domName;
  final MemoryChart _memoryChart;

  // We're going to dynamically add the Event timeline chart to our memory
  // profiler chart.
  EventTimeline eventTimeline;

  AxisLayout getXAxisLayout([int startTime = -1, int endTime = -1]) {
    return AxisLayout(
      type: 'date',
      tickformat: '%-I:%M:%S %p',
      hoverformat: '%H:%M:%S.%L %p',
      titlefont: Font(
        family: fontFamily,
        color: colorToCss(defaultForeground),
      ),
      tickfont: Font(
        family: fontFamily,
        color: colorToCss(defaultForeground),
      ),
      showgrid: true,
      gridcolor: colorToCss(defaultForeground.withAlpha(50)),
      gridwidth: 1,
      range: startTime == -1 ? [] : [startTime, endTime],
      rangeslider: startTime == -1
          ? RangeSlider()
          : RangeSlider(
              autorange: true,
            ),
    );
  }

  Layout getMemoryLayout(String chartTitle, [bool addEventTimeline = false]) {
    Layout layout;

    AxisLayout getYAxis(List<num> range) {
      return AxisLayout(
        domain: range,
        title: Title(
          text: 'Heap',
        ),
        titlefont: Font(
          family: fontFamily,
          color: colorToCss(defaultForeground),
        ),
        fixedrange: true,
        tickfont: Font(
          family: fontFamily,
          color: colorToCss(defaultForeground),
        ),
        showgrid: false,
        zeroline: false,
      );
    }

    Legend getLegend([bool events = false]) {
      return events
          ? Legend(
              font: Font(
                family: fontFamily,
                color: colorToCss(defaultForeground),
              ),
              orientation: "v",
              x: 1.03,
              xanchor: 'left',
              y: 1.1,
            )
          : Legend(
              font: Font(
                family: fontFamily,
                color: colorToCss(defaultForeground),
              ),
            );
    }

    final Margin margins = Margin(l: 80, r: 5, b: 5, t: 5, pad: 5);

    if (addEventTimeline) {
      layout = Layout(
        plot_bgcolor: colorToCss(chartBackground),
        paper_bgcolor: colorToCss(chartBackground),
        title: chartTitle,
        xaxis: getXAxisLayout(),
        yaxis: getYAxis([0, 0.90]),
        yaxis2: AxisLayout(
          domain: [.90, 1],
          anchor: 'y',
          side: 'right',
          showgrid: false,
          zeroline: false,
          showline: false,
          ticks: '',
          showticklabels: false,
          range: [.50, 1.50],
          type: 'linear',
          title: Title(
            text: 'Events',
            font: Font(
              family: fontFamily,
              size: 10,
            ),
          ),
        ),
        legend: getLegend(true),
        margin: margins,
        shapes: [
          // Background of event timeline subplot
          Shape(
            fillcolor: "#ccc",
            line: Line(
              width: 0,
            ),
            opacity: .5,
            type: "rect",
            xref: "paper",
            x0: 0,
            x1: 1,
            yref: "y2",
            y0: 0,
            y1: 2,
            layer: 'below',
          ),
        ],
      );
    } else {
      layout = Layout(
          plot_bgcolor: colorToCss(chartBackground),
          paper_bgcolor: colorToCss(chartBackground),
          title: chartTitle,
          legend: getLegend(),
          xaxis: getXAxisLayout(),
          yaxis: getYAxis([]),
          margin: margins);
    }

    return layout;
  }

  static const int MEMORY_GC_TRACE = 0;
  static const int MEMORY_EXTERNAL_TRACE = 1;
  static const int MEMORY_USED_TRACE = 2;
  static const int MEMORY_CAPACITY_TRACE = 3;
  static const int MEMORY_RSS_TRACE = 4;

  // Orange 50 - light is Orange 600, dark is Orange 900
  static String rssColor =
      colorToCss(const ThemedColor(Color(0xFFFB8C00), Color(0xFFE65100)));

  // Blue Gray 50 - list is Blue 700, dark is Blue 100
  static String capacityColor =
      colorToCss(const ThemedColor(Color(0xFF455A64), Color(0xFFCFD8DC)));

  // Light Blue 50 - light is Blue 800, dark is Blue 900
  static String externalColor =
      colorToCss(const ThemedColor(Color(0xFF0277BD), Color(0xFF01579B)));

  // Light Blue 50 - light is Blue 300, dark is Blue 400
  static String usedColor =
      colorToCss(const ThemedColor(Color(0xFF4FC3F7), Color(0xFF29B6F6)));

  // Light Blue 50 - light is Blue 500, dark is Blue 600
  static String gcColor =
      colorToCss(const ThemedColor(Color(0xFF03A9F4), Color(0xFF039BE5)));

  Data _createTrace(
    String name, {
    String color,
    String group,
    String dash,
    String symbol,
    int size,
  }) {
    int widthValue = 0;
    String modeName = '';

    Line line;
    if (color != null) {
      if (dash != null) {
        widthValue = 2;
        modeName = 'lines';
      }
      line = Line(
        color: color,
        dash: dash,
        width: widthValue,
      );
    }

    Marker marker;
    if (symbol != null) {
      marker = Marker(
        symbol: symbol,
        color: color,
        size: size,
      );
      modeName = 'markers';
    }

    if (marker == null) {
      return Data(
        x: [Null], // Trace legend entry appears w/o data.
        y: [Null], // Trace legend entry appears w/o data.
        text: [],
        line: line,
        type: 'scatter',
        mode: modeName,
        stackgroup: group != null ? 'one' : '',
        name: name,
        hoverinfo: 'y+name',
      );
    } else {
      return Data(
        x: [Null], // Trace legend entry appears w/o data.
        y: [Null], // Trace legend entry appears w/o data.
        text: [],
        marker: marker,
        type: 'scatter',
        mode: modeName,
        stackgroup: group != null ? 'one' : '',
        name: name,
        hoverinfo: 'y+name',
      );
    }
  }

  List<Data> createMemoryTraces() {
    final Data gcTrace = _createTrace(
      'GC',
      color: gcColor,
      symbol: 'circle',
      size: 10,
    );
    gcTrace.hoverinfo = 'x+name';

    final Data externalTrace = _createTrace(
      'External',
      color: externalColor,
      group: 'one',
    );
    final Data usedTrace = _createTrace(
      'Used',
      color: usedColor,
      group: 'one',
    );
    final Data capacityTrace = _createTrace(
      'Capacity',
      color: capacityColor,
      dash: 'dot',
    );
    final Data rssTrace = _createTrace(
      'RSS',
      color: rssColor,
      dash: 'dash',
    );
    rssTrace.visible = 'legendonly';

    return [gcTrace, externalTrace, usedTrace, capacityTrace, rssTrace];
  }

  // Resetting to live view, it's an autoscale back to full view.
  void _doubleClick(DataEvent data) => _memoryChart.resume();

  void plotMemory([createEventTimeline = false]) {
    List<Data> memoryTraces = createMemoryTraces();

    if (createEventTimeline) {
      eventTimeline = EventTimeline(_domName, _memoryChart.element);
      eventTimeline.addEventTimelineTo(memoryTraces);
    }

    Plotly.newPlot(
      _domName,
      memoryTraces,
      getMemoryLayout('', createEventTimeline),
      Configuration(
        responsive: true,
        displaylogo: false,
        displayModeBar: false,
      ),
    );

    doubleClick(_domName, _doubleClick);
  }

  bool get hasEventTimeline => eventTimeline != null;

  void createEventTimeline() {
    List<Data> memoryTraces = createMemoryTraces();

    eventTimeline = EventTimeline(_domName, _memoryChart.element);
    List<Data> eventTraces = eventTimeline.getEventTimelineTraces();

    eventTimeline.computeTraceIndexes(memoryTraces);

    Plotly.relayout(_domName, getMemoryLayout('', true));

    Plotly.addTraces(_domName, eventTraces, [
      eventTimeline.resetTraceIndex,
      eventTimeline.snapshotTraceIndex,
    ]);
  }

  void plotMarkersDataList(List<int> timestamps, List<num> gces) {
    extendTraces1(
      _domName,
      timestamps, // x coordinates for RSS trace.
      gces, // y coordinates for RSS trace.
      [
        MEMORY_GC_TRACE,
      ],
    );
  }

  void plotMemoryDataList(
    List<int> timestamps,
    List<num> rsses,
    List<num> capacities,
    List<num> uses,
    List<num> externals,
  ) {
    // TODO(terry): Eliminate this JS call (result of reified List?).
    extendTraces4(
      _domName,
      timestamps, // x coordinates for RSS trace.
      timestamps, // x coordinates for capacity trace.
      timestamps, // x coordinates for external trace.
      timestamps, // x coordinates for used trace.
      rsses, // y coordinates for RSS trace.
      capacities, // y coordinates for capacity trace.
      externals, // y coordinates for external trace.
      uses, // y coordinates for used trace.
      [
        MEMORY_RSS_TRACE,
        MEMORY_CAPACITY_TRACE,
        MEMORY_EXTERNAL_TRACE,
        MEMORY_USED_TRACE,
      ],
    );

    if (liveUpdate) {
      // Display 2 minutes of collected data in the chart, all data is accessible.
      final int startTime = DateTime.fromMillisecondsSinceEpoch(timestamps[0])
          .subtract(const Duration(minutes: 2))
          .millisecondsSinceEpoch;
      rangeSliderToLast(startTime, timestamps[0]);
    }
  }

  void rangeSliderToLast(int startTime, int endTime) {
    Plotly.update(
      _domName,
      [Data()],
      Layout(
        xaxis: getXAxisLayout(startTime, endTime),
      ),
    );
  }

  bool liveUpdate = true;

  void setLiveUpdate({bool live}) {
    liveUpdate = live;
  }

  void plotSnapshot() {
    if (!hasEventTimeline) createEventTimeline();

    final List data = getProperty(_memoryChart.element, 'data');
    var capacityTrace = data[MEMORY_CAPACITY_TRACE];
    var timestamp = capacityTrace.x[capacityTrace.x.length - 1];

    eventTimeline.plotSnapshot(timestamp);
  }

  void plotReset() {
    if (!hasEventTimeline) createEventTimeline();

    final List data = getProperty(_memoryChart.element, 'data');
    var capacityTrace = data[MEMORY_CAPACITY_TRACE];
    var timestamp = capacityTrace.x[capacityTrace.x.length - 1];

    eventTimeline.plotReset(timestamp);
  }
}

class EventTimeline {
  dynamic _chart;
  EventTimeline(this._domName, this._chart);

  // Trace index within the traces passed to addEventTimelineTo
  int resetTraceIndex;
  int snapshotTraceIndex;
  List<Data> addEventTimelineTo(List<Data> traces) {
    List<Data> eventTraces = getEventTimelineTraces();

    resetTraceIndex = traces.length;
    traces.add(eventTraces[RESET_TRACE_INDEX]); // Reset trace.

    snapshotTraceIndex = traces.length;
    traces.add(eventTraces[SNAPSHOT_TRACE_INDEX]); // Snapshot trace.

    return traces;
  }

  void computeTraceIndexes(List<Data> traces) {
    resetTraceIndex = traces.length;
    snapshotTraceIndex = resetTraceIndex + 1;
  }

  final String _domName;

  // Indexes for traces returned from getEventTimelineTraces
  static const int RESET_TRACE_INDEX = 0;
  static const int SNAPSHOT_TRACE_INDEX = 1;
  List<Data> getEventTimelineTraces() {
    // Create traces for the event timeline subplot.

    Data resetTrace = Data(
      x: [Null], // Trace legend entry appears w/o data.
      y: [Null], // Trace legend entry appears w/o data.
      name: 'Reset',
      type: 'scatter',
      mode: 'markers',
      yaxis: 'y2',
      marker: Marker(
        color: 'blue',
        line: Line(
          color: 'lightblue',
          width: 2,
        ),
        size: 5,
        symbol: "hexagon2-open-dot",
      ),
      hoverinfo: 'name+x',
      showlegend: true,
    );

    Data snapshotTrace = Data(
      x: [Null], // Trace legend entry appears w/o data.
      y: [Null], // Trace legend entry appears w/o data.
      name: 'Snapshot',
      type: 'scatter',
      mode: 'markers',
      yaxis: 'y2',
      marker: Marker(
        color: 'blue',
        line: Line(
          color: 'lightblue',
          width: 2,
        ),
        size: 10,
        symbol: "hexagon2-open",
      ),
      hoverinfo: 'name+x',
      showlegend: true,
    );

    return [resetTrace, snapshotTrace];
  }

  static const String _EVENT_MEMORY = 'mem';
  static const String _SNAPSHOT_EVENT = 's';
  static const String _RESET_EVENT = 'r';

  String lastEventType = '';
  int lastEventTime = -1;

  void displayDuration(int time, String eventType) {
    if (eventType == _SNAPSHOT_EVENT) {
      lastEventType = eventType;
      lastEventTime = time;
      return;
    }

    final Layout layout = getProperty(_chart, 'layout');
    final List<Shape> shapes = layout.shapes;

    int nextShape = shapes.length;

    Shape lastShape = shapes[nextShape - 1];

    bool isPaperShape = false;
    bool isSnapshotShape = false;
    bool isResetShape = false;
    if (lastShape.xref == 'paper') {
      // First shape that colors the entire event timeline chart.
      isPaperShape = true;
    } else if (lastShape.yref == 'y2') {
      // We're a snapshot or reset.
    }

    var jsShape = createEventShape(
        '$_EVENT_MEMORY: $lastEventType > $eventType',
        nextShape,
        lastEventTime,
        time);
    Plotly.relayout(_domName, jsShape);

    lastEventTime = time;
    lastEventType = eventType;
  }

  void plotSnapshot(int timestamp) {
    extendTraces1(_domName, [timestamp], [1], [snapshotTraceIndex]);
    displayDuration(timestamp, _SNAPSHOT_EVENT);
  }

  void plotReset(int timestamp) {
    extendTraces1(_domName, [timestamp], [1], [resetTraceIndex]);
    displayDuration(timestamp, _RESET_EVENT);
  }
}
