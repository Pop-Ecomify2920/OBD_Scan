// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:obd_scan/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // Pump frames to handle any animations
    await tester.pump();
    
    // Verify splash screen is shown
    expect(find.text('OBD Scan'), findsOneWidget);
    
    // Advance time to complete the splash screen timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
  });
}
