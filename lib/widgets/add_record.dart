import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:image_picker/image_picker.dart';

class Addrecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  Addrecord({Key? key}) : super(key: key);

  @override
  _AddrecordState createState() => _AddrecordState();
}

class _AddrecordState extends State<Addrecord> {
  dynamic title, age, place, pic;
  Box box = Boxes.getInstance();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add New Student",
        style: GoogleFonts.rubik(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      content: Form(
        key: widget.formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 5),
              profileImage(pic),
              const SizedBox(height: 8),
              buildName(),
              const SizedBox(height: 5),
              buildAge(),
              const SizedBox(height: 5),
              buildPlace(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        cancelButton(context),
        submitButton(context),
      ],
    );
  }

  Widget profileImage(dynamic pic) {
    if (pic != null) {
      Uint8List imageBytes = base64Decode(pic);
      return GestureDetector(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.memory(
            imageBytes,
            height: 130,
            width: 130,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () => pickImage(ImageSource.gallery),
      );
    }
    return GestureDetector(
      child: const CircleAvatar(
        backgroundImage: AssetImage(
          "assets/images/av2.jpg",
        ),
        radius: 70,
      ),
      onTap: () => pickImage(ImageSource.gallery),
    );
  }

  File? image;
  dynamic path;
  pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
    }
    setState(() {
      if (image != null) {
        path = image.path;
      }
    });
  }

  Widget buildName() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Name',
        ),
        validator: (value) {
          List<Record> students = box.get("students");
          if (value == "") {
            return "Student Name required";
          }
          if (students.where((element) => element.title == value).isNotEmpty) {
            return "This name student already here";
          }
        },
        onChanged: (value) {
          title = value;
        },
      );
  Widget buildPlace() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Place Name',
        ),
        validator: (value) {
          if (value == "") {
            return "Place Name required";
          }
        },
        onChanged: (value) {
          place = value;
        },
      );
  Widget buildAge() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Age',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Age required";
          }
        },
        onChanged: (value) {
          age = value;
        },
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
  Widget submitButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
        ),
        onPressed: () {
          if (widget.formkey.currentState!.validate()) {
            List<Record> students = box.get("students");
            students.add(
              Record(
                title,
                age,
                place,
                pic,
              ),
            );
            box.put("students", students);
            Get.back();
          }
        },
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
