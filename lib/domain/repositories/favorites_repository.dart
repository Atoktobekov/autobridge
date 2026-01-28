import '../entities/favorite_car.dart';

abstract class FavoritesRepository {
  Stream<List<FavoriteCar>> watchFavorites();
  Future<void> toggleFavorite(String carId);
  bool isFavorite(String carId);
}
