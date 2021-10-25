import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

class StudentSearch extends StatefulWidget {
  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  String _searchText = "";
  var names;
  late Uint8List imageBytes;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(7),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search Student",
            ),
            onChanged: (value) {
              setState(
                () {
                  _searchText = value;
                  print(_searchText);
                },
              );
            },
          ),
        ),
        Container(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Record>('records').listenable(),
            builder: (context, Box<Record> box, _) {
              var results = _searchText.isEmpty
                  ? box.values.toList()
                  : box.values
                      .where(
                        (c) => c.title.toLowerCase().contains(
                              _searchText.toLowerCase(),
                            ),
                      )
                      .toList();
              return results.isEmpty
                  ? Center(
                      child: Text(
                        'No results found !',
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          Record? record = box.getAt(index);

                          this.names = record!.title;

                          if (record.pic != null) {
                            imageBytes = base64Decode(record.pic);

                            return Container(
                              padding: EdgeInsets.all(6),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 7.0,
                                  horizontal: 16.0,
                                ),
                                leading: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.memory(
                                    imageBytes,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                tileColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentDetails(
                                        record.title,
                                        record.age,
                                        record.place,
                                        record.pic,
                                        index,
                                        box,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  record.title,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            padding: EdgeInsets.all(6),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 7.0,
                                horizontal: 16.0,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/av1.png",
                                ),
                                radius: 25,
                              ),
                              tileColor: Colors.white,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentDetails(
                                      record.title,
                                      record.age,
                                      record.place,
                                      record.pic,
                                      index,
                                      box,
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                record.title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        )
      ],
    );
  }
}
