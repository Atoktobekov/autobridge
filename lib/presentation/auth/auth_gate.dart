import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:autobridge/app/app_scope.dart';
import 'package:autobridge/domain/entities/user_profile.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';
import 'package:autobridge/presentation/root/root_page.dart';
import 'package:autobridge/presentation/auth/auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = AppScope.of(context);
    final authRepository = dependencies.authRepository;
    final userRepository = dependencies.userRepository;

    return StreamBuilder<User?>(
      stream: authRepository.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) {
          return const AuthPage();
        }
        return _UserBootstrap(
          user: user,
          userRepository: userRepository,
        );
      },
    );
  }
}

class _UserBootstrap extends StatelessWidget {
  const _UserBootstrap({
    required this.user,
    required this.userRepository,
  });

  final User user;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: userRepository.ensureUserProfile(
        UserProfile(
          id: user.uid,
          email: user.email ?? '',
          role: 'user',
        ),
      ),
      builder: (context, snapshot) {
        return RootPage(userId: user.uid);
      },
    );
  }
}
