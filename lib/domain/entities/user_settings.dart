import 'package:hive_ce_flutter/hive_flutter.dart';

part 'user_settings.g.dart';

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
