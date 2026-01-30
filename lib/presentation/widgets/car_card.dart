import 'package:flutter/material.dart';

import 'package:autobridge/domain/entities/car.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.car,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  final Car car;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final price = car.priceUsd > 0 ? '\$${car.priceUsd.toStringAsFixed(0)}' : 'Цена по запросу';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (car.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  car.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    color: Colors.blueGrey.shade50,
                    alignment: Alignment.center,
                    child: const Icon(Icons.directions_car, size: 48),
                  ),
                ),
              )
            else
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.directions_car, size: 48),
              ),
            const SizedBox(height: 12),
            Text(
              '${car.brand} ${car.model}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text('Год: ${car.year} • Пробег: ${car.mileage} км'),
            const SizedBox(height: 4),
            Text('Статус: ${car.status}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    price,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  color: isFavorite ? Colors.redAccent : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
