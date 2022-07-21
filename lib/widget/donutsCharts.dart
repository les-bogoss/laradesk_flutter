/// Donut chart example. This is a simple pie chart with a hole in the middle.
// ignore_for_file: unnecessary_new

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  // ignore: use_key_in_widget_constructors
  const DonutPieChart(this.seriesList, {required this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart<int>(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 15,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }
}

/// Sample linear data type.
class DonutsData {
  DonutsData(this.n, this.name, this.value, this.color);

  final String name;
  final int n;
  final int value;
  final charts.Color color;
}
