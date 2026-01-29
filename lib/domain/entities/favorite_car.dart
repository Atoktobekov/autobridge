import 'package:hive_ce_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class FavoriteCar {
  FavoriteCar({
    required this.carId,
    required this.addedAt,
  });

  @HiveField(0)
  final String carId;

  @HiveField(1)
  final DateTime addedAt;
}

class FavoriteCarAdapter extends TypeAdapter<FavoriteCar> {
  @override
  int get typeId => 1;

  @override
  FavoriteCar read(BinaryReader reader) {
    final fields = <int, dynamic>{
      for (var i = 0; i < reader.readByte(); i++) reader.readByte(): reader.read(),
    };
    return FavoriteCar(
      carId: fields[0] as String,
      addedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCar obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.carId)
      ..writeByte(1)
      ..write(obj.addedAt);
  }
}
