import 'package:hive/hive.dart';

part 'record_adapter.g.dart';

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  int? age;
  @HiveField(2)
  String? place;
  @HiveField(3)
  dynamic pic;

  Record(
    this.title,
    this.age,
    this.place,
    this.pic,
  );
}
