import 'package:hive_ce_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class UserSettings {
  UserSettings({
    required this.currency,
    required this.language,
  });

  @HiveField(0)
  final String currency;

  @HiveField(1)
  final String language;

  UserSettings copyWith({
    String? currency,
    String? language,
  }) {
    return UserSettings(
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}

class UserSettingsAdapter extends TypeAdapter<UserSettings> {
  @override
  int get typeId => 2;

  @override
  UserSettings read(BinaryReader reader) {
    final fields = <int, dynamic>{
      for (var i = 0; i < reader.readByte(); i++) reader.readByte(): reader.read(),
    };
    return UserSettings(
      currency: fields[0] as String,
      language: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.language);
  }
}
