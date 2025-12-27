import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';

class VehicleStatusScreen extends StatelessWidget {
  const VehicleStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: const Center(
          child: Text('Vehicle Status Screen - To be implemented'),
        ),
      ),
    );
  }
}

