import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/controllers.dart/student_controller.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:student_records/widgets/update_record.dart';

// ignore: must_be_immutable
class StudentDetails extends StatelessWidget {
  StudentDetails({Key? key, required this.student}) : super(key: key);

  Record student;
  final studentController = Get.find<StudentController>();
  Box<Record> box = Boxes.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpdateRecord(
                  student: student,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              studentController.deleteStudent(student.key);
              Get.back();
            },
          ),
        ],
        elevation: 0.0,
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder(
        builder: (StudentController studentController) {
          return ListView(
            children: [
              showProfile(student.pic),
              details(student.title, "Name :  "),
              details(student.age, "Age :  "),
              details(student.place, "Place :  ")
            ],
          );
        },
      ),
    );
  }

  Widget details(dynamic name, String heading) => Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 40,
          right: 40,
        ),
        child: ListTile(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 16.0,
          ),
          tileColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(heading),
              Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      );

  Widget showProfile(dynamic pic) {
    if (pic != null) {
      Uint8List imageBytes = base64Decode(pic);
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.memory(
          imageBytes,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        "assets/images/av1.png",
        height: 200,
        width: 200,
      ),
    );
  }
}
