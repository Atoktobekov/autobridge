import '../entities/car.dart';

abstract class CarRepository {
  Stream<List<Car>> watchCars();
  Future<void> addCar(Car car);
  Future<void> updateCar(Car car);
  Future<void> deleteCar(String id);
}
