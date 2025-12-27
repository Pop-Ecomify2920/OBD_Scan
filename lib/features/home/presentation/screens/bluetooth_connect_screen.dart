import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_background.dart';

class BluetoothConnectScreen extends StatelessWidget {
  const BluetoothConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackground(
        child: const Center(
          child: Text('Bluetooth Connect Screen - To be implemented'),
        ),
      ),
    );
  }
}

