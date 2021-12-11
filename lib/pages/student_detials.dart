// ignore_for_file: type_init_formals

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';

// ignore: must_be_immutable
class StudentDetails extends StatelessWidget {
  StudentDetails({Key? key, required this.keyName}) : super(key: key);
  int keyName;
  Box<Record> box = Boxes.getInstance();
  @override
  Widget build(BuildContext context) {
    Record? record = box.get(keyName);
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
              // showDialog(
              //   context: context,
              //   builder: (context) => UpdateRecord(
              //     title2: name,
              //     age2: age,
              //     place2: place,
              //     box2: box,
              //     index2: ind,
              //   ),
              // );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () async {
              await box.delete(keyName);
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
      body: ListView(
        children: [
          showProfile(record!.pic),
          details(record.title, "Name :  "),
          details(record.age, "Age :  "),
          details(record.place, "Place :  ")
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
Widget details(dynamic name, String heading) {
  return Container(
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
}

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
