import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_records/database/box_instance.dart';
import 'package:student_records/database/record_adapter.dart';

class StudentController extends GetxController {
  // StudentController({this.student});
  List<Record>? _students;
  List<Record> get students => _students!;
  Box<Record> box = Boxes.getInstance();
  Record? student;

  addStudent(title, age, place, pic) {
    box.add(
      Record(title, age, place, pic),
    );
  }

  deleteStudent(int key) {
    box.delete(key);
  }
}

class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
  }
}
