import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/controllers.dart/student_controller.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Addrecord extends StatelessWidget {
  Addrecord({Key? key}) : super(key: key);
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
              profileImage(),
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

  Widget profileImage() => GetBuilder<StudentController>(
        builder: (_) => GestureDetector(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: studentController.imageBytes == null
                ? const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/av2.jpg",
                    ),
                    radius: 70,
                  )
                : Image.memory(
                    studentController.imageBytes!,
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
          ),
          onTap: () async {
            pic = await studentController.pickImage(ImageSource.gallery, pic);
          },
        ),
      );

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
            print(pic);
            studentController.addStudent(title, age, place, pic);
            studentController.imageBytes = null;
            Get.back();
          }
        },
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
