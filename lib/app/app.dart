import 'package:flutter/material.dart';

import 'package:autobridge/app/service_locator.dart';
import 'package:autobridge/presentation/auth/auth_gate.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AutobridgeApp extends StatelessWidget {
  const AutobridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final talker = getIt<Talker>();
    return MaterialApp(
      title: 'Autobridge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      navigatorObservers: [TalkerRouteObserver(talker)],
      home: const AuthGate(),
    );
  }
}
