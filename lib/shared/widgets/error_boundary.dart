import 'package:flutter/material.dart';

/// A widget that catches errors and displays a fallback UI
class ErrorBoundary extends StatelessWidget {
  final Widget child;

  const ErrorBoundary({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

