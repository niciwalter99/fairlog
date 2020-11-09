import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'package:fairlog/pages/Overview/Overview.dart';
import 'package:fairlog/member/teamMember.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange[400],
          //accentColor: Colors.green,
          //textTheme: TextTheme(bodyText2: TextStyle(color: Colors.grey)),
          //hoverColor: Colors.orange[500], //TODO hovercolor
        ),
      home: Home(),//ConfettiSample(),
      /*initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/teamlist': (context) => TeamList(),
        '/editmem': (context) => EditMemberList(),
        '/chooseProtocolant': (context) => ChooseProtocolant(),
      } */

  ));
}
