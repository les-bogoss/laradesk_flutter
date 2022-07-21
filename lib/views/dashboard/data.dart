import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laradesk_flutter/widget/donutsCharts.dart';
import 'package:laradesk_flutter/widget/linearCharts.dart';
import 'package:laradesk_flutter/widget/columnCharts.dart';
import 'package:laradesk_flutter/widget/card.dart';
import 'package:laradesk_flutter/controllers/get_dashboard_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late List<charts.Series<DonutsData, int>> _category = [];
  late List<charts.Series<DonutsData, int>> _status = [];
  late List<charts.Series<dynamic, DateTime>> _openClose = [];
  late List<charts.Series<ColumnData, String>> _satisfaction = [];

  Future<List> _chartdata() async {
    _category = [];
    var response = await getdata();

    List<DonutsData> categoryData = [];
    List<DonutsData> statusData = [];
    List<MyRow> openData = [];
    List<MyRow> closeData = [];
    List<ColumnData> satisfactionData = [];
    Map<String, dynamic> ticketCategory =
        json.decode(response)["ticket_category"];
    List<dynamic> ticketStatus = json.decode(response)["ticket_status"];
    List<dynamic> ticketOpen = json.decode(response)["ticket_open_date"];
    List<dynamic> ticketClose = json.decode(response)["ticket_close_date"];
    List<dynamic> ticketSatisfaction = json.decode(response)["ticket_rating"];
    num total = 0;
    int i = 0;
    List<String> colors = [
      "#FFDD4A",
      "#7E38F3",
      "#C9E8FC",
      "#3DBD00",
      "#C5D0FA",
      "#F8D5C4"
    ];

    List<String> colorsSatisfaction = ["#f88e55", "#fef86c", "#90ee90"];

    ticketCategory.forEach((category, number) {
      categoryData.add(DonutsData(
          i, category, number, charts.Color.fromHex(code: colors[i])));
      total = total + int.parse(number.toString());
      i++;
    });

    total = 0;
    i = 0;
    for (var map in ticketStatus) {
      map.forEach((status, number) {
        statusData.add(DonutsData(
            i, status, number, charts.Color.fromHex(code: colors[i])));
        total = total + number;
        i++;
      });
    }

    i = ticketOpen.length;
    for (var map in ticketOpen) {
      map.forEach((date, number) {
        openData.add(MyRow(DateTime.parse(date), number));
        i--;
      });
    }

    i = ticketClose.length;
    for (var map in ticketClose) {
      map.forEach((date, number) {
        closeData.add(MyRow(DateTime.parse(date), number));
        i--;
      });
    }

    for (var map in ticketSatisfaction) {
      map.forEach((name, value) {
        String color = "";
        switch (name) {
          case "1":
            name = "Moyen";
            color = colorsSatisfaction[0];
            break;
          case "2":
            name = "Bon";
            color = colorsSatisfaction[1];
            break;
          case "3":
            name = "Excellent";
            color = colorsSatisfaction[2];
            break;
        }
        satisfactionData
            .add(ColumnData(name, (value * 10).round() / 10, color));
        i--;
      });
    }

    _category = [
      charts.Series<DonutsData, int>(
          id: 'category',
          domainFn: (DonutsData cat, _) => cat.n,
          measureFn: (DonutsData cat, _) => cat.value,
          data: categoryData,
          labelAccessorFn: (DonutsData info, _) =>
              '${info.name}\n${(info.value * 100 / total * 10).round() / 10}%',
          colorFn: (DonutsData cat, _) => cat.color),
    ];

    _status = [
      charts.Series<DonutsData, int>(
          id: 'status',
          domainFn: (DonutsData statut, _) => statut.n,
          measureFn: (DonutsData statut, _) => statut.value,
          data: statusData,
          labelAccessorFn: (DonutsData info, _) =>
              '${info.name}\n${(info.value * 100 / total * 10).round() / 10}%',
          colorFn: (DonutsData statut, _) => statut.color),
    ];

    _openClose = [
      charts.Series<MyRow, DateTime>(
        id: 'Ticket\nOpen',
        colorFn: (_, __) => charts.Color.fromHex(code: "#FFDD4A"),
        domainFn: (MyRow open, _) => open.timeStamp,
        measureFn: (MyRow open, _) => open.value,
        data: openData,
      ),
      charts.Series<MyRow, DateTime>(
        id: 'Ticket\nClose',
        colorFn: (_, __) => charts.Color.fromHex(code: "#7E38F3"),
        domainFn: (MyRow close, _) => close.timeStamp,
        measureFn: (MyRow close, _) => close.value,
        data: closeData,
      )
    ];

    _satisfaction = [
      charts.Series<ColumnData, String>(
        id: 'Satisfaction',
        domainFn: (ColumnData satisfaction, _) => satisfaction.name,
        measureFn: (ColumnData satisfaction, _) => satisfaction.value,
        data: satisfactionData,
        labelAccessorFn: (ColumnData satisfaction, _) =>
            '${satisfaction.value}%',
        colorFn: (ColumnData satisfaction, _) =>
            charts.Color.fromHex(code: satisfaction.color),
      ),
    ];
    return [_category, _status, _openClose, _satisfaction];
  }

  @override
  initState() {
    super.initState();
    _chartdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF094074),
          elevation: 0,
        ),
        body: FutureBuilder(
            future: _chartdata(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  ChartCard(DonutPieChart(snapshot.data![0], animate: true)),
                  ChartCard(
                    DonutPieChart(snapshot.data![1], animate: true),
                  ),
                  ChartCard(
                    CustomAxisTickFormatters(snapshot.data![2], animate: false),
                  ),
                  ChartCard(
                    VerticalBarLabelChart(snapshot.data![3], animate: false),
                  ),
                ];
                return ListView(
                  children: children,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
