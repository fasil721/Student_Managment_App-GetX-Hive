import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/controller/student_controller.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:student_records/pages/search_page.dart';
import 'package:student_records/widgets/add_record.dart';
import 'package:student_records/pages/student_detials.dart';

class HomePage extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final studentController = Get.find<StudentController>();
  String? title, place;
  dynamic pic;
  int? age;
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
            child: IconButton(
              icon: Image.asset("assets/images/search.png"),
              onPressed: () {
                Get.to(() => SearchPage());
              },
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
            margin: const EdgeInsets.only(bottom: 10),
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
          Expanded(
            child: GetBuilder<StudentController>(
              builder: (_) {
                return studentController.box.values.isEmpty
                    ? const Center(
                        child: Text(
                          'No Students records',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: studentController.box.values.length,
                        itemBuilder: (context, index) {
                          Record? record = studentController.box.getAt(index);
                          if (record!.pic != null) {
                            imageBytes = base64Decode(record.pic!);
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
                                child: record.pic == null
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
                                    student: record,
                                  ),
                                );
                              },
                              title: Text(
                                record.title!,
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
