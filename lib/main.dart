import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/database/record_adapter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox('records');

  Box box = Boxes.getInstance();
  List keys = box.keys.toList();
  if (keys.isEmpty) {
    List<Record> students = [];
     box.put("students", students);
  }

  runApp(
    const GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
