import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_records/controllers.dart/student_controller.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/database/record_adapter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  await Hive.openBox<Record>('records');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/HomePage",
          page: () => const HomePage(),
          binding: StudentBinding(),
        ),
      ],
      initialRoute: "/HomePage",
    ),
  );
}
