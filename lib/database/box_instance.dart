import 'package:hive/hive.dart';
import 'package:student_records/database/record_adapter.dart';

class Boxes {
  static Box? _box;

  static Box getInstance() {
    _box ??= Hive.box('records');
    return _box!;
  }
  // static List<dynamic> getStudents() {
  //   _box ??= Hive.box('records');
  //   return _box!.get("students");
  // }
}
