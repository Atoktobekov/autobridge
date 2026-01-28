import 'package:hive/hive.dart';

import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../services/hive_boxes.dart';

class HiveSettingsRepository implements SettingsRepository {
  Box<UserSettings> get _box => Hive.box<UserSettings>(HiveBoxes.settings);

  @override
  Stream<UserSettings> watchSettings() async* {
    final current = _box.get('settings') ??
        UserSettings(
          currency: 'USD',
          language: 'Русский',
        );
    yield current;
    await for (final _ in _box.watch()) {
      final next = _box.get('settings') ?? current;
      yield next;
    }
  }

  @override
  Future<void> updateSettings(UserSettings settings) async {
    await _box.put('settings', settings);
  }
}
