import 'package:hive/hive.dart';
import 'package:student_records/database/record_adapter.dart';

class Boxes {
  static Box<Record>? _box;

  static Box<Record> getInstance() {
    _box ??= Hive.box<Record>('records');
    return _box!;
  }
}
