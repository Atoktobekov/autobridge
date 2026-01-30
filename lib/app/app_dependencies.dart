import 'package:autobridge/domain/repositories/auth_repository.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/domain/repositories/favorites_repository.dart';
import 'package:autobridge/domain/repositories/request_repository.dart';
import 'package:autobridge/domain/repositories/settings_repository.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.authRepository,
    required this.carRepository,
    required this.requestRepository,
    required this.userRepository,
    required this.favoritesRepository,
    required this.settingsRepository,
  });

  final AuthRepository authRepository;
  final CarRepository carRepository;
  final RequestRepository requestRepository;
  final UserRepository userRepository;
  final FavoritesRepository favoritesRepository;
  final SettingsRepository settingsRepository;
}
