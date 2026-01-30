import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autobridge/domain/entities/car.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/data/models/car_model.dart';

class FirestoreCarRepository implements CarRepository {
  FirestoreCarRepository({FirebaseFirestore? firestore})
      : _collection = (firestore ?? FirebaseFirestore.instance).collection('cars');

  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Stream<List<Car>> watchCars() {
    return _collection.orderBy('updatedAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map(CarModel.fromDoc).toList(),
        );
  }

  @override
  Future<void> addCar(Car car) async {
    final model = CarModel(
      id: car.id,
      brand: car.brand,
      model: car.model,
      year: car.year,
      mileage: car.mileage,
      priceUsd: car.priceUsd,
      priceKgs: car.priceKgs,
      imageUrl: car.imageUrl,
      status: car.status,
    );
    await _collection.add(model.toMap());
  }

  @override
  Future<void> updateCar(Car car) async {
    final model = CarModel(
      id: car.id,
      brand: car.brand,
      model: car.model,
      year: car.year,
      mileage: car.mileage,
      priceUsd: car.priceUsd,
      priceKgs: car.priceKgs,
      imageUrl: car.imageUrl,
      status: car.status,
    );
    await _collection.doc(car.id).set(model.toMap(), SetOptions(merge: true));
  }

  @override
  Future<void> deleteCar(String id) async {
    await _collection.doc(id).delete();
  }
}
