import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  int _currentIndex = 1; // Location index (assuming safety is location)

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        // Already on safety/location
        break;
      case 2:
        // Car/Vehicle screen
        break;
      case 3:
        context.go(RouteNames.settings);
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
                child: Text('Safety Screen - To be implemented'),
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

