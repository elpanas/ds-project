import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class LocalBath extends HiveObject {
  @HiveField(0)
  String bid;

  @HiveField(1)
  String name;

  @HiveField(2)
  String city;

  LocalBath({
    required this.bid,
    required this.name,
    required this.city,
  });
}
