import 'package:hive_ce_flutter/hive_flutter.dart';

part 'favorite_car.g.dart';

@HiveType(typeId: 1)
class FavoriteCar {
  FavoriteCar({
    required this.carId,
    required this.addedAt,
  });

  @HiveField(0)
  final String carId;

  @HiveField(1)
  final DateTime? addedAt;
}


