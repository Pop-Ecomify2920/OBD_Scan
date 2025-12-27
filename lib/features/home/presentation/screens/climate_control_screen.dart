import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class ClimateControlScreen extends StatefulWidget {
  const ClimateControlScreen({super.key});

  @override
  State<ClimateControlScreen> createState() => _ClimateControlScreenState();
}

class _ClimateControlScreenState extends State<ClimateControlScreen> {
  int _currentIndex = 0; // Home index (climate is part of home)

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
        context.go(RouteNames.vehicleStatus);
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
                child: Text('Climate Control Screen - To be implemented'),
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

