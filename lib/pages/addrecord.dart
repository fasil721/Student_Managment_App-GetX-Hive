import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/record_adapter.dart';

class Addrecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  // final Record? record;
  // final Function(String title, String place) onClickedDone;

  // Addrecord({
  //   Key? key,
  //   this.record,
  //   required this.onClickedDone,
  // }) : super(key: key);

  @override
  _AddrecordState createState() => _AddrecordState();
}

class _AddrecordState extends State<Addrecord> {
  late String title, place;
  submitData() async {
    if (widget.formkey.currentState!.validate()) {
      Box<Record> todoBox = Hive.box<Record>('records');
      todoBox.add(
        Record(title, place),
      );
      Navigator.of(context).pop();
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
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildAge(),
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
  Widget buildAge() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Student Place',
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
        onPressed: submitData,
        child: Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
