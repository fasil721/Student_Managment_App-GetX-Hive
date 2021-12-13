import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';

class StudentController extends GetxController {
  Box<Record> box = Boxes.getInstance();
  Record? student;
  File? image;
  Uint8List? imageBytes;
  dynamic path;
  String searchText = "";

  addStudent(title, age, place, pic) {
    box.add(
      Record(title, age, place, pic),
    );
    update();
  }

  deleteStudent(int key) {
    box.delete(key);
    update();
  }

  textSearch(String txt) {
    searchText = txt;
    update();
  }

  dynamic pickImage(ImageSource source,pic) async {
   
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes!);
    }
    if (image != null) {
      path = image.path;
    }
    update();
    return pic;
  }
}

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
  }
}
