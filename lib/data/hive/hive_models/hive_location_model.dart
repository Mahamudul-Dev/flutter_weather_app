import 'package:hive/hive.dart';
part '../generated/hive_location_model.g.dart';

@HiveType(typeId: 3)
class HiveLocationModel extends HiveObject {

  @HiveField(0)
  double? lat;
  @HiveField(1)
  double? lon;
  @HiveField(2)
  String? city;
  @HiveField(3)
  String? country;
  @HiveField(4)
  String? state;

  HiveLocationModel({
    this.lat,
    this.lon,
    this.city,
    this.country,
    this.state
  });
}
