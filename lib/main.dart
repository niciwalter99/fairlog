import 'file:///D:/IISL/apps/fairlog/lib/pages/ChooseProtocolant/chooseProtocolant.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/EditTeamList/teamList.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/ChooseProtocolant/yourprotocolant.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/EditTeamList/editMemberList.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/ChooseProtocolant/chooseProtocolant.dart';
import 'file:///D:/IISL/apps/fairlog/lib/pages/ChooseProtocolant/presentList.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange,
          accentColor: Colors.green,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey)),
          hoverColor: Colors.orange[500],
        ),
      home: Home(),
      /*initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/teamlist': (context) => TeamList(),
        '/editmem': (context) => EditMemberList(),
        '/chooseProtocolant': (context) => ChooseProtocolant(),
      } */

  ));
}
