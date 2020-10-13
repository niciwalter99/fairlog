import 'package:fairlog/pages/teamList.dart';
import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'package:fairlog/pages/editMemberList.dart';

void main() {
  runApp(
      MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => TeamList(),
        '/editmem': (context) => EditMemberList(),
      }

  ));
}
