import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

class UpdateRecord extends StatefulWidget {
  UpdateRecord({
    Key? key,
    required this.title2,
    required this.place2,
    required this.box2,
    required this.index2,
  }) : super(key: key);

  late String title2;
  late String place2;
  late dynamic box2;
  late int index2;

  final formkey = GlobalKey<FormState>();

  @override
  _UpdateRecordState createState() =>
      _UpdateRecordState(title2, place2, box2, index2);
}

class _UpdateRecordState extends State<UpdateRecord> {
  late String title2;
  late String place2;
  late dynamic box2;
  late int index2;
  _UpdateRecordState(
    String this.title2,
    String this.place2,
    dynamic this.box2,
    int this.index2,
  );
  late String title, place;
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
        child: Builder(
          builder: (context) {
            Record? record = box2.getAt(index2);
            return TextFormField(
              initialValue: title2,
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
                setState(() {});
              },
            );
          },
        ),
      );
  Widget buildAge() => Container(
        child: Builder(builder: (context) {
          Record? record = box2.getAt(index2);
          return TextFormField(
            initialValue: place2,
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
                  record!.place = value;
                  record.save();
                },
              );
            },
          );
        }),
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
  Widget submitButton(BuildContext context) => Builder(builder: (context) {
        Record? record = box2.getAt(index2);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[200],
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDetails(
                record!.title,
                record.place,
                index2,
                box2,
              ),
            ),
          ),
          child: Text(
            'Save',
            style: TextStyle(color: Colors.black),
          ),
        );
      });
}
