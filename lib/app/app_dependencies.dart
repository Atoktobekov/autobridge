import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/car_repository.dart';
import '../domain/repositories/favorites_repository.dart';
import '../domain/repositories/request_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/user_repository.dart';

class AppDependencies {
  AppDependencies({
    required this.authRepository,
    required this.carRepository,
    required this.requestRepository,
    required this.userRepository,
    required this.favoritesRepository,
    required this.settingsRepository,
    required this.httpClient,
    required this.logger,
  });

  final AuthRepository authRepository;
  final CarRepository carRepository;
  final RequestRepository requestRepository;
  final UserRepository userRepository;
  final FavoritesRepository favoritesRepository;
  final SettingsRepository settingsRepository;
  final Dio httpClient;
  final Talker logger;
}
