import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';

class ClimateControlScreen extends StatelessWidget {
  const ClimateControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: const Center(
          child: Text('Climate Control Screen - To be implemented'),
        ),
      ),
    );
  }
}

