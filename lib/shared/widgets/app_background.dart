import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// A reusable background widget that displays a flexible gradient background
/// Can optionally overlay a background image
class AppBackground extends StatelessWidget {
  final Widget child;
  final String? imagePath;
  final BoxFit fit;
  final LinearGradient? gradient;
  final bool useImageOverlay;

  const AppBackground({
    super.key,
    required this.child,
    this.imagePath,
    this.fit = BoxFit.cover,
    this.gradient,
    this.useImageOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    // Use provided gradient or default to AppColors.backgroundGradient
    final backgroundGradient = gradient ?? AppColors.backgroundGradient;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          // Primary gradient background (always applied) - fills full screen
          gradient: backgroundGradient,
          // Optional image overlay (only if enabled)
          image: useImageOverlay && imagePath != null
              ? DecorationImage(
                  image: AssetImage(imagePath!),
                  fit: fit,
                  // Blend the image with the gradient
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 27, 26, 26).withOpacity(0.3),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}

