import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/record_adapter.dart';

class Addrecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
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
      title: Text("Add New Student"),
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
  Widget submitButton(BuildContext context) => Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: submitData,
          child: Text(
            'Save Data',
          ),
        ),
      );
}
