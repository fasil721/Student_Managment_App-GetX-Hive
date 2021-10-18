import 'package:flutter/material.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/pages/record_adapter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox<Record>('records');
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
