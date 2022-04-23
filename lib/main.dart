import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypt/crypt.dart';
part 'CalendarPage.dart';
part 'SecondPage.dart';
part 'AttendancePage.dart';
part 'LoginPage.dart';
part 'Communication.dart';
part 'MainPage.dart';
part 'AdminPage.dart';
part 'AddCoachPage.dart';
part 'AddMemberPage.dart';
part 'ViewMembersPage.dart';
part 'ViewTrainingsPage.dart';

void main() => runApp(const SummitApp());

class SummitApp extends StatelessWidget {
  const SummitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
