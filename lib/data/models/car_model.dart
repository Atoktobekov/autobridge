import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autobridge/domain/entities/car.dart';

class CarModel extends Car {
  CarModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.year,
    required super.mileage,
    required super.priceUsd,
    required super.priceKgs,
    required super.imageUrl,
    required super.status,
  });

  factory CarModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return CarModel(
      id: doc.id,
      brand: data['brand'] as String? ?? '',
      model: data['model'] as String? ?? '',
      year: (data['year'] as num?)?.toInt() ?? 0,
      mileage: (data['mileage'] as num?)?.toInt() ?? 0,
      priceUsd: (data['priceUsd'] as num?)?.toDouble() ?? 0,
      priceKgs: (data['priceKgs'] as num?)?.toDouble() ?? 0,
      imageUrl: data['imageUrl'] as String? ?? '',
      status: data['status'] as String? ?? 'inStock',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'mileage': mileage,
      'priceUsd': priceUsd,
      'priceKgs': priceKgs,
      'imageUrl': imageUrl,
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
