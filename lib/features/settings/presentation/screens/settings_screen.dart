import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: const Center(
          child: Text('Settings Screen - To be implemented'),
        ),
      ),
    );
  }
}

