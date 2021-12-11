import 'package:hive/hive.dart';

part 'record_adapter.g.dart';

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  dynamic title;
  @HiveField(1)
  dynamic age;
  @HiveField(2)
  dynamic place;
  @HiveField(3)
  dynamic pic;

  Record(
    this.title,
    this.age,
    this.place,
    this.pic,
  );
}
