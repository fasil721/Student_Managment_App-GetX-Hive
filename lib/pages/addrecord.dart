import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/record_adapter.dart';

class AddRecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  late String title, description;

  submitData() async {
    if (widget.formkey.currentState!.validate()) {
      Box<Record> todoBox = Hive.box<Record>('records');
      todoBox.add(Record(title, description));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add todo", style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Form(
        key: widget.formkey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Add title'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Add description'),
              onChanged: (value) {
                setState(
                  () {
                    description = value;
                  },
                );
              },
            ),
            ElevatedButton(onPressed: submitData, child: Text('Submit Data'))
          ],
        ),
      ),
    );
  }
}
