import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';
import 'package:student_records/widgets/add_record.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchText = "";
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
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
        leading: Image.asset("assets/images/hamburger.png"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: const Icon(
              Icons.more_vert_sharp,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
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
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Student",
                fillColor: Colors.grey,
              ),
              onChanged: (value) {
                setState(
                  () {
                    _searchText = value;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Boxes.getInstance().listenable(),
              builder: (context, Box<Record> box, _) {
                List<int> keys = box.keys.cast<int>().toList();
                List<Record> results = _searchText.isEmpty
                    ? box.values.toList()
                    : box.values
                        .where(
                          (c) => c.title
                              .toLowerCase()
                              .contains(_searchText.toLowerCase()),
                        )
                        .toList();

                return results.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found !',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          if (results[index].pic != null) {
                            imageBytes = base64Decode(results[index].pic);
                          }
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 7.0,
                                horizontal: 16.0,
                              ),
                              leading: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: results[index].pic == null
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/av1.png",
                                        ),
                                        radius: 25,
                                      )
                                    : Image.memory(
                                        imageBytes!,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              tileColor: Colors.white,
                              onTap: () {
                                Get.to(
                                  () => StudentDetails(
                                    keyName: keys[index],
                                  ),
                                );
                              },
                              title: Text(
                                results[index].title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
