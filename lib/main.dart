import 'package:fairlog/pages/chooseProtocolant.dart';
import 'package:fairlog/pages/teamList.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'package:fairlog/pages/editMemberList.dart';
import 'package:fairlog/pages/chooseProtocolant.dart';
import 'package:fairlog/pages/presentList.dart';

void main() {
  runApp(
      MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/teamlist': (context) => TeamList(),
        '/editmem': (context) => EditMemberList(),
        '/chooseProtocolant': (context) => ChooseProtocolant(),
        '/presentList': (context) => PresentList(),
      }

  ));
}
