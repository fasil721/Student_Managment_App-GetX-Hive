import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addrecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  @override
  _AddrecordState createState() => _AddrecordState();
}

class _AddrecordState extends State<Addrecord> {
  late var title, age, place;
  dynamic pic;
  dynamic id = 1;
  submitData(context) async {
    if (widget.formkey.currentState!.validate()) {
      Box<Record> todoBox = Hive.box<Record>('records');
      todoBox.add(
        Record(title, age, place, pic),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.grey[200],
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
              SizedBox(height: 5),
              ProfileImage(pic),
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 5),
              buildAge(),
              SizedBox(height: 5),
              buildPlace(),
              // SizedBox(height: 5),
              // buildImage(),
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

  Widget ProfileImage(dynamic pic) {
    if (pic != null) {
      Uint8List imageBytes = base64Decode(pic);
      return Container(
        child: GestureDetector(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
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
        ),
      );
    }
    return GestureDetector(
      child: CircleAvatar(
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
    setState(
      () {
        if (image != null) {
          path = image.path;
        }
      },
    );
  }

  Widget buildName() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Student Name',
          ),
          validator: (value) {
            if (value == "") {
              return "Student Name required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                title = value;
              },
            );
          },
        ),
      );
  Widget buildPlace() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Place Name',
          ),
          validator: (value) {
            if (value == "") {
              return "Place Name required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                place = value;
              },
            );
          },
        ),
      );
  Widget buildAge() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Student Age',
          ),
          validator: (value) {
            if (value == "") {
              return "Student Age required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                age = value;
              },
            );
          },
        ),
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: Text(
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
            Box<Record> todoBox = Hive.box<Record>('records');
            todoBox.add(
              Record(
                title,
                age,
                place,
                pic,
              ),
            );
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
