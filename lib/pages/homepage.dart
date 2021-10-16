import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/pages/addrecord.dart';
import 'package:student_records/pages/record_adapter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Addrecord(),
        ),
      ),
      backgroundColor: Colors.grey[200],
      drawer: Drawer(),
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
                delegate: _StudentSearch(),
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
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        Record? record = box.getAt(index);
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/images/av1.png",
                              ),
                              radius: 25,
                            ),
                            tileColor: Colors.white,
                            onTap: () {},
                            onLongPress: () async {
                              await box.deleteAt(index);
                            },
                            title: Text(
                              record!.title,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            // subtitle: Text(
                            //   record.place,
                            //   style: TextStyle(
                            //       fontSize: 16, fontFamily: 'Montserrat'),
                            // ),
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

// Expanded(
//   child: ListView(
//     shrinkWrap: true,
//     scrollDirection: Axis.vertical,
//     children: [
//       Container(
//         padding: EdgeInsets.only(left: 23),
//         child: Text(
//           "Student Records",
//           style: GoogleFonts.recursive(
//             fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w400,
//             fontSize: 30,
//           ),
//         ),
//       ),
class _Students extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("object");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _detialspage(),
          ),
        );
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

class _detialspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class _StudentSearch extends SearchDelegate<String> {
  final cities = ['Ankara', 'İzmir', 'İstanbul', 'Samsun', 'Sakarya'];
  var recentCities = ['Ankara'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.cabin),
      onPressed: () {},
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(
        (Icons.arrow_back),
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      );
}
