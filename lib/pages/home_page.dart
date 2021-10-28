import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/pages/add_record.dart';
import 'package:student_records/pages/student_search.dart';
import 'package:student_records/pages/record_adapter.dart';

class HomePage extends StatelessWidget {
  var names;
  late Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Addrecord(),
        ),
      ),
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
        ),
      ),
      appBar: AppBar(
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Image.asset("assets/images/hamburger.png"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Student Records",
              style: GoogleFonts.recursive(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(
              20,
            ),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Record>('records').listenable(),
              builder: (context, Box<Record> box, _) {
                if (box.values.isEmpty) {
                  return Center(
                    child: Text(
                      "No records available!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    StudentSearch(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
