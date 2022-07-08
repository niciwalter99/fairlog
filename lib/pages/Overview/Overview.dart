import 'package:fairlog/db/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


import 'Mem.dart';
import 'chart.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final List<Member> data = [];


  @override
  void initState() {
    writeData();
    super.initState();
  }

  void writeData() async{
    List<Map<String, dynamic>>? t = await DataBaseHelper.instance.queryAll();

    int? length = t?.length;

    for(int i = 0; i < length!; i++) {
        data.add(Member(name: t![i][DataBaseHelper.columnName] ,
            protocols: int.parse(t![i][DataBaseHelper.columnWrittenProtocol]),
            barColor: charts.ColorUtil.fromDartColor(Colors.orange[200]!)
        ));
    }

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: new EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new SizedBox(
              height: 500.0,
              child:  MemberChart(data: data),
            ),
          ],
        ),
      ));
  }
}
