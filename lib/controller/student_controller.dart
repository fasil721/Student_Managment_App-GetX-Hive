import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';

class StudentController extends GetxController {
  Box<Record> box = Boxes.getInstance();
  Uint8List? imageBytes;

  addStudent(String title, int age, String place, pic) {
    box.add(
      Record(title, age, place, pic),
    );
    update();
  }

  deleteStudent(int key) {
    box.delete(key);
    update();
  }

  dynamic pickImage(ImageSource source) async {
    dynamic pic;
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes!);
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
