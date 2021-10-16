import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Students extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("object");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 75,
        margin: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 10,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 12),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/av1.png",
                ),
                radius: 25,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "John",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
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
