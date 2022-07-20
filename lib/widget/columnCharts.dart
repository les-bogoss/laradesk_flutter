/// Vertical bar chart with bar label renderer example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class VerticalBarLabelChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  VerticalBarLabelChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barRendererDecorator: charts.BarLabelDecorator(
          insideLabelStyleSpec: const charts.TextStyleSpec(
              fontSize: 12, color: charts.MaterialPalette.black)),
      domainAxis: const charts.OrdinalAxisSpec(),
    );
  }
}

/// Sample ordinal data type.
class ColumnData {
  final String name;
  final double value;
  final String color;
  ColumnData(this.name, this.value, this.color);
}
