/// Vertical bar chart with bar label renderer example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final dynamic chart;

  ChartCard(this.chart);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 175.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: chart,
        ),
      ),
    );
  }
}
