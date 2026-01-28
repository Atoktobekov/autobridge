import 'package:flutter/material.dart';

import '../favorites/favorites_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.userId});

  final String userId;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(userId: widget.userId),
      FavoritesPage(userId: widget.userId),
      ProfilePage(userId: widget.userId),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.directions_car),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Избранное',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
