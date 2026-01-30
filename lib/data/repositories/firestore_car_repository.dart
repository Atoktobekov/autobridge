import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autobridge/domain/entities/car.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/data/models/car_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FirestoreCarRepository implements CarRepository {
  FirestoreCarRepository({FirebaseFirestore? firestore, Talker? talker})
      : _collection = (firestore ?? FirebaseFirestore.instance).collection('cars'),
        _talker = talker;

  final CollectionReference<Map<String, dynamic>> _collection;
  final Talker? _talker;

  @override
  Stream<List<Car>> watchCars() {
    return _collection.snapshots().map((snapshot) {
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        final updatedAt = data['updatedAt'];
        return _CarSnapshot(
          car: CarModel.fromDoc(doc),
          updatedAt: updatedAt is Timestamp ? updatedAt : null,
        );
      }).toList();
      items.sort((a, b) {
        final aTime = a.updatedAt ?? Timestamp(0, 0);
        final bTime = b.updatedAt ?? Timestamp(0, 0);
        return bTime.compareTo(aTime);
      });
      _talker?.debug('Loaded cars', {'count': items.length});
      return items.map((item) => item.car).toList();
    });
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
    _talker?.info('Added car', {'brand': car.brand, 'model': car.model});
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
    _talker?.info('Updated car', {'id': car.id});
  }

  @override
  Future<void> deleteCar(String id) async {
    await _collection.doc(id).delete();
    _talker?.warning('Deleted car', {'id': id});
  }
}

class _CarSnapshot {
  _CarSnapshot({required this.car, required this.updatedAt});

  final Car car;
  final Timestamp? updatedAt;
}
