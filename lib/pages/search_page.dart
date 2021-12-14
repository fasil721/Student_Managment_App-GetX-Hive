import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/controller/student_controller.dart';
import 'package:student_records/pages/student_detials.dart';
import 'package:student_records/database/record_adapter.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leadingWidth: 75,
          toolbarHeight: 70,
          backgroundColor: Colors.grey[200],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Search a student",
            style: GoogleFonts.roboto(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
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
                  searchText = value;
                  studentController.update();
                },
              ),
            ),
            Expanded(
              child: GetBuilder<StudentController>(
                builder: (_) {
                  List<Record> results = studentController.box.values
                      .where(
                        (c) => c.title!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()),
                      )
                      .toList();
                  return results.isEmpty
                      ? Center(
                          child: Text(
                            'No results found !',
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : searchText.isEmpty
                          ? Container()
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                Uint8List? imageBytes;
                                if (results[index].pic != null) {
                                  imageBytes =
                                      base64Decode(results[index].pic!);
                                }
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                          student: results[index],
                                        ),
                                      );
                                    },
                                    title: Text(
                                      results[index].title!,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 10),
                            );
                },
              ),
            )
            // : Container(),
          ],
        ),
      ),
    );
  }
}
