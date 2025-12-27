import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class VehicleStatusScreen extends StatefulWidget {
  const VehicleStatusScreen({super.key});

  @override
  State<VehicleStatusScreen> createState() => _VehicleStatusScreenState();
}

class _VehicleStatusScreenState extends State<VehicleStatusScreen> {
  int _currentIndex = 2; // Car/Vehicle index

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
        // Already on vehicle status
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
                child: Text('Vehicle Status Screen - To be implemented'),
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

