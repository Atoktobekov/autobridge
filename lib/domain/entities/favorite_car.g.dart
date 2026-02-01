// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_car.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCarAdapter extends TypeAdapter<FavoriteCar> {
  @override
  final typeId = 1;

  @override
  FavoriteCar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCar(
      carId: fields[0] as String,
      addedAt: fields[1] as DateTime?,
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
