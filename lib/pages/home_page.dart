import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/widgets/add_record.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/pages/student_detials.dart';
import 'package:student_records/database/record_adapter.dart';
import 'package:student_records/controllers.dart/student_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formkey = GlobalKey<FormState>();
  final studentController = Get.find<StudentController>();
  dynamic title, age, place, pic;
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
          builder: (context) => const Addrecord(),
        ),
        // onPressed: () => Get.defaultDialog(
        //   title: "Add New Student",
        //   content: Form(
        //     key: formkey,
        //     child: Column(
        //       children: <Widget>[
        //         const SizedBox(height: 5),
        //         profileImage(pic),
        //         const SizedBox(height: 8),
        //         buildName(),
        //         const SizedBox(height: 5),
        //         buildAge(),
        //         const SizedBox(height: 5),
        //         buildPlace(),
        //       ],
        //     ),
        //   ),
        //   actions: <Widget>[
        //     cancelButton(),
        //     submitButton(),
        //   ],
        // ),
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
                                    student: results[index],
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

  Widget profileImage(dynamic pic) {
    if (pic != null) {
      imageBytes = base64Decode(pic);
    }
    return GestureDetector(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: pic == null
            ? const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/av2.jpg",
                ),
                radius: 70,
              )
            : Image.memory(
                imageBytes!,
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
      ),
      onTap: () => pickImage(ImageSource.gallery),
    );
  }

  File? image;

  dynamic path;

  pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
    }
    setState(() {
      if (image != null) {
        path = image.path;
      }
    });
  }

  Widget buildName() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Name',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Name required";
          }
        },
        onChanged: (value) {
          title = value;
        },
      );

  Widget buildPlace() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Place Name',
        ),
        validator: (value) {
          if (value == "") {
            return "Place Name required";
          }
        },
        onChanged: (value) {
          place = value;
        },
      );

  Widget buildAge() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Student Age',
        ),
        validator: (value) {
          if (value == "") {
            return "Student Age required";
          }
        },
        onChanged: (value) {
          age = value;
        },
      );

  Widget cancelButton() => TextButton(
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Get.back(),
      );

  Widget submitButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            studentController.addStudent(title, age, place, pic);
            Get.back();
          }
        },
        child: const Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
