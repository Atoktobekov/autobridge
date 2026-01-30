import 'package:flutter/material.dart';

import 'package:autobridge/app/app_scope.dart';
import 'package:autobridge/domain/entities/car.dart';
import 'package:autobridge/domain/entities/favorite_car.dart';
import 'package:autobridge/presentation/widgets/car_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppScope.of(context);
    final favoritesRepository = dependencies.favoritesRepository;
    final carRepository = dependencies.carRepository;

    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: StreamBuilder<List<FavoriteCar>>(
        stream: favoritesRepository.watchFavorites(),
        builder: (context, favoritesSnapshot) {
          final favorites = favoritesSnapshot.data ?? [];
          final favoriteIds = favorites.map((favorite) => favorite.carId).toSet();
          return StreamBuilder<List<Car>>(
            stream: carRepository.watchCars(),
            builder: (context, carsSnapshot) {
              final cars = carsSnapshot.data ?? [];
              final items = cars.where((car) => favoriteIds.contains(car.id)).toList();
              if (items.isEmpty) {
                return const Center(child: Text('Нет избранных авто'));
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final car = items[index];
                  return CarCard(
                    car: car,
                    isFavorite: true,
                    onFavoriteToggle: () {
                      favoritesRepository.toggleFavorite(car.id);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
