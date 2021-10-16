import 'package:hive/hive.dart';

part 'record_adapter.g.dart';

@HiveType(typeId: 1)
class Record {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  Record(this.title, this.description);
}