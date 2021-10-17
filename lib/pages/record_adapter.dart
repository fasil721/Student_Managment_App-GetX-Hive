import 'package:hive/hive.dart';

part 'record_adapter.g.dart';

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  late var title;
  @HiveField(1)
  late var age;
  @HiveField(2)
  late var place;

  Record(
    this.title,
    this.age,
    this.place,
  );
}
