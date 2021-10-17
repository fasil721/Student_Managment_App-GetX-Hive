import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/pages/addrecord.dart';
import 'package:student_records/pages/homepage.dart';
import 'package:student_records/pages/updaterecord.dart';

class StudentDetails extends StatelessWidget {
  String name;
  String age;
  String place;
  int index;
  var box;
  StudentDetails(String this.name, String this.age, String this.place,
      int this.index, var this.box);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          // Container(
          //   child: ValueListenableBuilder(
          //       valueListenable: Hive.box<Record>('records').listenable(),
          //       builder: (context, Box<Record> box, _) {
          //         temp = box;
          //         return Text("s");
          //       }),
          // ),
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
                  index2: index,
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
              await box.deleteAt(index);
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
          ClipRRect(
            borderRadius: BorderRadius.circular(82.0),
            child: Image.asset(
              "assets/images/av1.png",
              height: 200,
            ),
          ),
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
