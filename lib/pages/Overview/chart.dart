import 'package:flutter/material.dart';
import 'Mem.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class MemberChart extends StatelessWidget {

  final List<Member> data;

  MemberChart({required this.data});
  @override
  Widget build(BuildContext context) {

    List<charts.Series<Member, String>> series = [
      charts.Series(
        id: "Written Protocols",
        data: data,
        domainFn: (Member series, _) => series.name,
        measureFn: (Member series, _) => series.protocols,
        colorFn: (Member series, _) => series.barColor,

      )
    ];
    return charts.BarChart(series, animate: true,);
  }
}

