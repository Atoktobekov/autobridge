class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.mileage,
    required this.priceUsd,
    required this.priceKgs,
    required this.imageUrl,
    required this.status,
  });

  final String id;
  final String brand;
  final String model;
  final int year;
  final int mileage;
  final double priceUsd;
  final double priceKgs;
  final String imageUrl;
  final String status;
}
