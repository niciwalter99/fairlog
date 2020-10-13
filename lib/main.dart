import 'package:flutter/material.dart';
import 'package:fairlog/pages/home.dart';
import 'package:fairlog/pages/home2.dart';
import 'package:fairlog/pages/home3.dart';
import 'package:fairlog/pages/editMemberList.dart';

void main() {
  runApp(
      MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => EditMemberList(),
      }
  ));
}
