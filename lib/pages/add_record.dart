import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addrecord extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  @override
  _AddrecordState createState() => _AddrecordState();
}

class _AddrecordState extends State<Addrecord> {
  late var title, age, place;
  dynamic pic;

  // late var gender = "";
  submitData() async {
    if (widget.formkey.currentState!.validate()) {
      Box<Record> todoBox = Hive.box<Record>('records');
      todoBox.add(
        Record(
          title,
          age,
          place,
          pic,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.grey[200],
      title: Text(
        "Add New Student",
        style: GoogleFonts.rubik(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      content: Form(
        key: widget.formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 5),
              ProfileImage(pic),
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 5),
              buildAge(),
              SizedBox(height: 5),
              buildPlace(),
              // SizedBox(height: 5),
              // buildImage(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        cancelButton(context),
        submitButton(context),
      ],
    );
  }

  Widget ProfileImage(dynamic pic) {
    if (pic != null) {
      Uint8List imageBytes = base64Decode(pic);
      return Container(
        child: GestureDetector(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.memory(
              imageBytes,
              height: 130,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () => pickImage(ImageSource.gallery),
        ),
      );
    }
    return GestureDetector(
      child: CircleAvatar(
        backgroundImage: AssetImage(
          "assets/images/av1.png",
        ),
        radius: 60,
      ),
      onTap: () => pickImage(ImageSource.gallery),
    );
  }

  Widget buildImage() => Container(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 15.0,
          ),
          title: Row(
            children: [
              Text(
                "Add Photo",
                style: GoogleFonts.rubik(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/ic1.jpg",
                    ),
                    radius: 19,
                  ),
                ),
                onTap: () => pickImage(ImageSource.gallery),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/ic2.png",
                    ),
                    radius: 22,
                  ),
                ),
                onTap: () {
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
          tileColor: Colors.grey[200],
        ),
      );

  File? image;
  var path;
  pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
      print(pic);
    }
    setState(
      () {
        if (image != null) {
          path = image.path;
        }
      },
    );
  }

  //     final imageTemporary = await saveImagePermanently(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print("Failed to pick image : $e");
  //   }
  // }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File("${directoty.path}/$name");
  // }
  // takePhoto(ImageSource source) async {
  //   images = (await _picker.pickImage(
  //     source: source,
  //   ));
  //   if (images != null) {
  //     Uint8List imageBytes = await images!.readAsBytes();
  //     base64Image = base64Encode(imageBytes);
  //     print(base64Image);
  //   }

  // setState(() {
  //   if (images != null) {
  //     path = images!.path;
  //   }
  // });
  // }

  //late XFile images;
  // pickImageFromGallary(ImageSource source) {
  //   imageFile = ImagePicker.pickImage(source: source) as Future<File>;
  // }
  // Widget imageDialog(BuildContext context) {
  //   return AlertDialog(
  //     content: Column(
  //       children: [
  //         Container(
  //           child: ListTile(
  //             contentPadding: EdgeInsets.symmetric(
  //               vertical: 0.0,
  //               horizontal: 15.0,
  //             ),
  //             leading: Text("fas"),
  //             tileColor: Colors.grey[200],
  //             onTap: () {},
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget RadioButtons() => Row(
  //       children: [
  //         RadioListTile<String>(
  //           title: Text('Expense'),
  //           value: "male",
  //           groupValue: gender,
  //           onChanged: (value) => setState(() => gender = value!),
  //         ),
  //         RadioListTile<String>(
  //           title: Text('Income'),
  //           value: "female",
  //           groupValue: gender,
  //           onChanged: (value) => setState(() => gender = value!),
  //         ),
  //       ],
  //     );
  Widget buildName() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Student Name',
          ),
          validator: (value) {
            if (value == "") {
              return "Student Name required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                title = value;
              },
            );
          },
        ),
      );
  Widget buildPlace() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Place Name',
          ),
          validator: (value) {
            if (value == "") {
              return "Place Name required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                place = value;
              },
            );
          },
        ),
      );
  Widget buildAge() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Student Age',
          ),
          validator: (value) {
            if (value == "") {
              return "Student Age required";
            }
          },
          onChanged: (value) {
            setState(
              () {
                age = value;
              },
            );
          },
        ),
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
  Widget submitButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
        ),
        onPressed: submitData,
        child: Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
