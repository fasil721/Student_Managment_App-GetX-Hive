import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

class UpdateRecord extends StatefulWidget {
  UpdateRecord({
    Key? key,
    required this.title2,
    required this.age2,
    required this.place2,
    required this.box2,
    required this.index2,
  }) : super(key: key);

  late String title2;
  late String age2;
  late String place2;
  late dynamic box2;
  late int index2;

  final formkey = GlobalKey<FormState>();

  @override
  _UpdateRecordState createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  //late String title, place;
  // submitData() async {
  //   if (widget.formkey.currentState!.validate()) {
  //     Box<Record> record = Hive.box<Record>('records');

  //     Navigator.of(context).pop();
  //   }
  // }

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
              SizedBox(height: 8),
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

  Widget buildAge() => Container(
        child: Builder(
          builder: (context) {
            Record? record = widget.box2.getAt(widget.index2);
            return TextFormField(
              initialValue: widget.age2,
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
                    record!.age = value;
                    record.save();
                  },
                );
              },
            );
          },
        ),
      );

  Widget buildName() => Container(
        child: Builder(
          builder: (context) {
            Record? record = widget.box2.getAt(widget.index2);
            return TextFormField(
              initialValue: widget.title2,
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
                    record!.title = value;
                    record.save();
                  },
                );
              },
            );
          },
        ),
      );
  Widget buildPlace() => Container(
        child: Builder(
          builder: (context) {
            Record? record = widget.box2.getAt(widget.index2);
            return TextFormField(
              initialValue: widget.place2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Student Place',
              ),
              validator: (value) {
                if (value == "") {
                  return "Student Place required";
                }
              },
              onChanged: (value) {
                setState(
                  () {
                    record!.place = value;
                    record.save();
                  },
                );
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
  Widget submitButton(BuildContext context) => Builder(
        builder: (context) {
          Record? record = widget.box2.getAt(widget.index2);
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
            ),
            onPressed: () {
              if (widget.formkey.currentState!.validate()) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetails(
                      record!.title,
                      record.age,
                      record.place,
                      widget.index2,
                      widget.box2,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      );
}
