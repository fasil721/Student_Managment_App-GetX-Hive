import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

// ignore: must_be_immutable
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
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Edit Student Detials",
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
              const SizedBox(height: 8),
              buildName(),
              const SizedBox(height: 8),
              buildAge(),
              const SizedBox(height: 8),
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

  Widget buildAge() => Builder(
        builder: (context) {
          Record? record = widget.box2.getAt(widget.index2);
          return TextFormField(
            initialValue: widget.age2,
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
              record!.age = value;
              record.save();
            },
          );
        },
      );

  Widget buildName() => Builder(
        builder: (context) {
          Record? record = widget.box2.getAt(widget.index2);
          return TextFormField(
            initialValue: widget.title2,
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
              record!.title = value;
              record.save();
            },
          );
        },
      );
  Widget buildPlace() => Builder(
        builder: (context) {
          Record? record = widget.box2.getAt(widget.index2);
          return TextFormField(
            initialValue: widget.place2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Student Place',
            ),
            validator: (value) {
              if (value == "") {
                return "Student Place required";
              }
            },
            onChanged: (value) {
              record!.place = value;
              record.save();
            },
          );
        },
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: const Text(
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
              // if (widget.formkey.currentState!.validate()) {
              //   Navigator.pop(context);
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => StudentDetails(
              //         record!.title,
              //         record.age,
              //         record.place,
              //         record.pic,
              //         widget.index2,
              //         widget.box2,
              //       ),
              //     ),
              //   );
              // }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      );
}
