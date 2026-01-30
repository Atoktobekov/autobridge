import 'package:autobridge/domain/entities/user_settings.dart';

abstract class SettingsRepository {
  Stream<UserSettings> watchSettings();
  Future<void> updateSettings(UserSettings settings);
}
