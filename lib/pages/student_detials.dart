import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetails extends StatelessWidget {
  String name;
  String place;
  StudentDetails(String this.name, String this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
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
            Navigator.pop(context);
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
                  fontSize: 17,
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
