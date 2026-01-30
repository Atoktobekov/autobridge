import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app_scope.dart';
import '../presentation/auth/auth_gate.dart';

class AutobridgeApp extends StatelessWidget {
  const AutobridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final talker = AppScope.of(context).logger;
    return MaterialApp(
      title: 'Autobridge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      navigatorObservers: [TalkerNavigatorObserver(talker)],
      home: const AuthGate(),
    );
  }
}
