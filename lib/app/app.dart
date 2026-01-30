import 'package:flutter/material.dart';

import 'package:autobridge/presentation/auth/auth_gate.dart';

class AutobridgeApp extends StatelessWidget {
  const AutobridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autobridge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
