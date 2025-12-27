import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: const Center(
          child: Text('Safety Screen - To be implemented'),
        ),
      ),
    );
  }
}

