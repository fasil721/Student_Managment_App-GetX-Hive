import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/pages/addrecord.dart';
import 'package:student_records/pages/student_search.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

class HomePage extends StatelessWidget {
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
          IconButton(
            icon: Image.asset(
              "assets/images/search.png",
              alignment: Alignment.centerLeft,
              width: 100,
              height: 50,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StudentSearch(),
              );
            },
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
                return Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        Record? record = box.getAt(index);
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
                                      record!.title,
                                      record.age,
                                      record.place,
                                      index,
                                      box),
                                ),
                              );
                            },
                            // onLongPress: () async {
                            //   await box.deleteAt(index);
                            // },
                            title: Text(
                              record!.title,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
