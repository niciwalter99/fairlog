import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'package:fairlog/pages/Overview/Overview.dart';
import 'package:fairlog/member/teamMember.dart';

void main() {
  Color c = Colors.orange[400] as Color;
  runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange[400],
          primarySwatch: Colors.orange ,
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
