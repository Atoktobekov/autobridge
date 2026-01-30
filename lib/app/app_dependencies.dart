import 'package:autobridge/domain/repositories/auth_repository.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/domain/repositories/favorites_repository.dart';
import 'package:autobridge/domain/repositories/request_repository.dart';
import 'package:autobridge/domain/repositories/settings_repository.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';
import 'package:autobridge/services/http_client.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppDependencies {
  AppDependencies({
    required this.authRepository,
    required this.carRepository,
    required this.requestRepository,
    required this.userRepository,
    required this.favoritesRepository,
    required this.settingsRepository,
    required this.httpClient,
    required this.dio,
    required this.talker,
  });

  final AuthRepository authRepository;
  final CarRepository carRepository;
  final RequestRepository requestRepository;
  final UserRepository userRepository;
  final FavoritesRepository favoritesRepository;
  final SettingsRepository settingsRepository;
  final AppHttpClient httpClient;
  final Dio dio;
  final Talker talker;
}
