import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:student_records/pages/update_record.dart';

class StudentDetails extends StatelessWidget {
  String name;
  String age;
  String place;
  dynamic pic;
  final ind;
  var box;
  StudentDetails(
    this.name,
    this.age,
    this.place,
    this.pic,
    this.ind,
    this.box,
  );

  @override
  Widget build(BuildContext context) {
    print(ind);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpdateRecord(
                  title2: name,
                  age2: age,
                  place2: place,
                  box2: box,
                  index2: ind,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () async {
              await box.deleteAt(ind);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
        elevation: 0.0,
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          showProfile(pic),
          Details(name, "Name :  "),
          Details(age, "Age :  "),
          Details(place, "Place :  ")
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  String name;
  String heading;
  Details(
    String this.name,
    String this.heading,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 40,
        right: 40,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 16.0,
        ),
        tileColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              child: Text(heading),
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget showProfile(dynamic pic) {
  if (pic != null) {
    Uint8List imageBytes = base64Decode(pic);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.memory(
        imageBytes,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Image.asset(
      "assets/images/av1.png",
      height: 200,
      width: 200,
    ),
  );
}
