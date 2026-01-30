
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:autobridge/app/app.dart';
import 'package:autobridge/app/service_locator.dart';
import 'package:autobridge/core/firebase/firebase_initializer.dart';
import 'package:autobridge/domain/entities/favorite_car.dart';
import 'package:autobridge/domain/entities/user_settings.dart';
import 'package:autobridge/services/http_client.dart';
import 'package:autobridge/services/hive_boxes.dart';

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

  final talker = TalkerFlutter.init();
  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  final dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printRequestData: true,
          printResponseHeaders: false,
          printResponseData: true,
          printResponseMessage: true,
        ),
      ),
    );
  final httpClient = AppHttpClient(dio: dio, talker: talker);

  setupDependencies(talker: talker, dio: dio, httpClient: httpClient);

  runApp(const AutobridgeApp());
}
