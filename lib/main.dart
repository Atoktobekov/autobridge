import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/app_dependencies.dart';
import 'app/app_scope.dart';
import 'core/firebase/firebase_initializer.dart';
import 'data/repositories/firebase_auth_repository.dart';
import 'data/repositories/firestore_car_repository.dart';
import 'data/repositories/firestore_request_repository.dart';
import 'data/repositories/firestore_user_repository.dart';
import 'data/repositories/hive_favorites_repository.dart';
import 'data/repositories/hive_settings_repository.dart';
import 'domain/entities/favorite_car.dart';
import 'domain/entities/user_settings.dart';
import 'services/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseInitializer.options,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteCarAdapter());
  Hive.registerAdapter(UserSettingsAdapter());
  await Hive.openBox<FavoriteCar>(HiveBoxes.favorites);
  await Hive.openBox<UserSettings>(HiveBoxes.settings);

  final dependencies = AppDependencies(
    authRepository: FirebaseAuthRepository(),
    carRepository: FirestoreCarRepository(),
    requestRepository: FirestoreRequestRepository(),
    userRepository: FirestoreUserRepository(),
    favoritesRepository: HiveFavoritesRepository(),
    settingsRepository: HiveSettingsRepository(),
  );

  runApp(AppScope(
    dependencies: dependencies,
    child: const AutobridgeApp(),
  ));
}
