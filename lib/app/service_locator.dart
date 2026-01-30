import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:autobridge/data/repositories/firebase_auth_repository.dart';
import 'package:autobridge/data/repositories/firestore_car_repository.dart';
import 'package:autobridge/data/repositories/firestore_request_repository.dart';
import 'package:autobridge/data/repositories/firestore_user_repository.dart';
import 'package:autobridge/data/repositories/hive_favorites_repository.dart';
import 'package:autobridge/data/repositories/hive_settings_repository.dart';
import 'package:autobridge/domain/repositories/auth_repository.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/domain/repositories/favorites_repository.dart';
import 'package:autobridge/domain/repositories/request_repository.dart';
import 'package:autobridge/domain/repositories/settings_repository.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';
import 'package:autobridge/services/http_client.dart';

final getIt = GetIt.instance;

void setupDependencies({
  required Talker talker,
  required Dio dio,
  required AppHttpClient httpClient,
}) {
  getIt
    ..registerSingleton<Talker>(talker)
    ..registerSingleton<Dio>(dio)
    ..registerSingleton<AppHttpClient>(httpClient)
    ..registerSingleton<AuthRepository>(FirebaseAuthRepository())
    ..registerSingleton<CarRepository>(FirestoreCarRepository(talker: talker))
    ..registerSingleton<RequestRepository>(FirestoreRequestRepository(talker: talker))
    ..registerSingleton<UserRepository>(FirestoreUserRepository(talker: talker))
    ..registerSingleton<FavoritesRepository>(HiveFavoritesRepository())
    ..registerSingleton<SettingsRepository>(HiveSettingsRepository());
}
