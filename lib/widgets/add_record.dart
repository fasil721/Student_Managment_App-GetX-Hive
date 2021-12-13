import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/controllers.dart/student_controller.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:image_picker/image_picker.dart';

class Addrecord extends StatefulWidget {
  const Addrecord({Key? key}) : super(key: key);

  @override
  State<Addrecord> createState() => _AddrecordState();
}

class _AddrecordState extends State<Addrecord> {
  dynamic title, age, place, pic;
  Box box = Boxes.getInstance();
  final formkey = GlobalKey<FormState>();
  final studentController = Get.find<StudentController>();

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
        key: formkey,
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
        cancelButton(),
        submitButton(),
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
          if (value == "") {
            return "Student Name required";
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

  Widget cancelButton() => TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Get.back(),
      );

  Widget submitButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            studentController.addStudent(title, age, place, pic);
            Get.back();
          }
        },
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
