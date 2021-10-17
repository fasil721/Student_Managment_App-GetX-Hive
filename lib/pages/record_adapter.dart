import 'package:hive/hive.dart';

part 'record_adapter.g.dart';

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String place;

  Record(this.title, this.place);
}
