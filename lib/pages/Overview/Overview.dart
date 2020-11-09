import 'package:fairlog/db/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List _elements = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
     List<Map<String,dynamic>> t = await DataBaseHelper.instance.queryAll();
     _elements = List<Map<String,dynamic>>.from(t);
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Overview"),
        centerTitle: true,
      ),
      body:  GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element[DataBaseHelper.columnTeam],
       // groupComparator: (value1, value2) => value2.compareTo(value1),
        //itemComparator: (item1, item2) =>
           // item1['name'].compareTo(item2['name']),
        //order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            elevation: 0.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                title: Text(element[DataBaseHelper.columnName]),
                trailing: Text(element[DataBaseHelper.columnWrittenProtocol]),
              ),
            ),
          );
        },
      ),
    );
  }
}
