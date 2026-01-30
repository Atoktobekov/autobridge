import 'package:flutter/material.dart';

import 'package:autobridge/app/app_scope.dart';
import 'package:autobridge/domain/entities/user_profile.dart';
import 'package:autobridge/domain/entities/user_settings.dart';
import 'package:autobridge/presentation/admin/admin_page.dart';
import 'package:autobridge/presentation/home/request_form_page.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppScope.of(context);
    final authRepository = dependencies.authRepository;
    final userRepository = dependencies.userRepository;
    final settingsRepository = dependencies.settingsRepository;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StreamBuilder<UserProfile?>(
            stream: userRepository.watchProfile(userId),
            builder: (context, snapshot) {
              final profile = snapshot.data;
              if (profile == null) {
                return const ListTile(
                  title: Text('Профиль'),
                  subtitle: Text('Загрузка...'),
                );
              }
              return ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  profile.email,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  profile.isAdmin ? 'Администратор' : 'Пользователь',
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: profile.isAdmin
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminPage(),
                            ),
                          );
                        },
                        child: const Text('Админка'),
                      )
                    : null,
              );
            },
          ),
          const SizedBox(height: 16),
          Text('Настройки', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          StreamBuilder<UserSettings>(
            stream: settingsRepository.watchSettings(),
            builder: (context, snapshot) {
              final settings = snapshot.data ??
                  UserSettings(
                    currency: 'USD',
                    language: 'Русский',
                  );
              return Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: settings.currency,
                    decoration: const InputDecoration(
                      labelText: 'Валюта',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'KGS', child: Text('KGS')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      settingsRepository.updateSettings(
                        settings.copyWith(currency: value),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: settings.language,
                    decoration: const InputDecoration(
                      labelText: 'Язык',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Русский', child: Text('Русский')),
                      DropdownMenuItem(value: 'Кыргызча', child: Text('Кыргызча')),
                      DropdownMenuItem(value: 'English', child: Text('English')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      settingsRepository.updateSettings(
                        settings.copyWith(language: value),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const RequestFormPage(),
                ),
              );
            },
            icon: const Icon(Icons.support_agent),
            label: const Text('Связаться с менеджером'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TalkerScreen(talker: dependencies.talker),
                ),
              );
            },
            icon: const Icon(Icons.bug_report_outlined),
            label: const Text('Логи приложения'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: authRepository.signOut,
            child: const Text('Выйти из аккаунта'),
          ),
        ],
      ),
    );
  }
}
