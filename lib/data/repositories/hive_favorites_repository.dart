import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:autobridge/domain/entities/favorite_car.dart';
import 'package:autobridge/domain/repositories/favorites_repository.dart';
import 'package:autobridge/services/hive_boxes.dart';

class HiveFavoritesRepository implements FavoritesRepository {
  Box<FavoriteCar> get _box => Hive.box<FavoriteCar>(HiveBoxes.favorites);

  @override
  Stream<List<FavoriteCar>> watchFavorites() {
    return _watchBox();
  }

  Stream<List<FavoriteCar>> _watchBox() async* {
    yield _box.values.toList(growable: false);
    await for (final _ in _box.watch()) {
      yield _box.values.toList(growable: false);
    }
  }

  @override
  bool isFavorite(String carId) {
    return _box.values.any((item) => item.carId == carId);
  }

  @override
  Future<void> toggleFavorite(String carId) async {
    final key = _box.keys.cast<dynamic?>().firstWhere(
          (element) => _box.get(element)?.carId == carId,
          orElse: () => null,
        );
    if (key == null) {
      await _box.add(FavoriteCar(carId: carId, addedAt: DateTime.now()));
    } else {
      await _box.delete(key);
    }
  }
}
