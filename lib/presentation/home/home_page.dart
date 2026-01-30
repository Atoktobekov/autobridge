import 'package:flutter/material.dart';

import 'package:autobridge/app/app_scope.dart';
import 'package:autobridge/domain/entities/car.dart';
import 'package:autobridge/domain/entities/favorite_car.dart';
import 'package:autobridge/presentation/widgets/car_card.dart';
import 'package:autobridge/presentation/home/request_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = AppScope.of(context);
    final carRepository = dependencies.carRepository;
    final favoritesRepository = dependencies.favoritesRepository;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные авто'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const RequestFormPage(),
                ),
              );
            },
            icon: const Icon(Icons.support_agent),
            tooltip: 'Связаться',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Поиск по марке или модели',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Car>>(
              stream: carRepository.watchCars(),
              builder: (context, snapshot) {
                final cars = snapshot.data ?? [];
                final query = _searchController.text.toLowerCase();
                final filtered = cars.where((car) {
                  return car.brand.toLowerCase().contains(query) ||
                      car.model.toLowerCase().contains(query);
                }).toList();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (filtered.isEmpty) {
                  return const Center(child: Text('Пока нет доступных машин'));
                }
                return StreamBuilder<List<FavoriteCar>>(
                  stream: favoritesRepository.watchFavorites(),
                  builder: (context, favoritesSnapshot) {
                    final favorites = favoritesSnapshot.data ?? [];
                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final car = filtered[index];
                        final isFavorite =
                            favorites.any((favorite) => favorite.carId == car.id);
                        return CarCard(
                          car: car,
                          isFavorite: isFavorite,
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
          ),
        ],
      ),
    );
  }
}
