import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 3; // Settings index

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.safety);
        break;
      case 2:
        // Car/Vehicle screen
        break;
      case 3:
        // Already on settings
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: const Center(
                child: Text('Settings Screen - To be implemented'),
              ),
            ),
            AppBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onNavItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}

