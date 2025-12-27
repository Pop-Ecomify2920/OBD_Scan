import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/error_boundary.dart';
import '../../../../core/routes/route_names.dart';
import 'home_screen.dart'; // For NotificationIconPainter and BluetoothButtonPainter

class BluetoothConnectScreen extends StatelessWidget {
  const BluetoothConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ErrorBoundary(
        child: AppBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: screenWidth,
                height: 870,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Header section
                    _buildHeader(screenWidth),
                    // Large Bluetooth icon
                    _buildLargeBluetoothIcon(screenWidth, screenHeight),
                    // Instructions text
                    _buildInstructionsText(screenWidth, screenHeight),
                    // Connect button
                    _buildConnectButton(context, screenWidth, screenHeight),
                    // Start without Bluetooth link
                    _buildStartWithoutBluetoothLink(context, screenWidth, screenHeight),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Positioned(
      left: 0.0,
      top: 26.0,
      right: 0.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: screenWidth,
          height: 100.0,
          child: Stack(
            children: [
              // Bluetooth icon (left)
              Positioned(
                left: 3.7,
                top: -20.0,
                child: SizedBox(
                  width: 125.0,
                  height: 125.0,
                  child: CustomPaint(
                    painter: HeaderBluetoothIconPainter(),
                  ),
                ),
              ),
              // Title and subtitle (center) - absolutely centered
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Mitsubishi X2",
                        style: GoogleFonts.inter(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Parked",
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(214, 214, 214, 1.0), // #d6d6d6
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Notification icon (right)
              Positioned(
                right: 28.0,
                top: 23.0,
                child: SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: CustomPaint(
                    painter: NotificationIconPainter(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeBluetoothIcon(double screenWidth, double screenHeight) {
    return Positioned(
      left: 20.0,
      top: 128.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: 380.0,
          height: 380.0,
          child: CustomPaint(
            painter: LargeBluetoothIconPainter(),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionsText(double screenWidth, double screenHeight) {
    return Positioned(
      left: 20.0,
      top: 543.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: screenWidth - 40.0,
          child: Text(
            "Turn on the Bluetooth connection of this device.",
            style: GoogleFonts.inter(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(245, 242, 242, 1), // #bdbdbd
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectButton(BuildContext context, double screenWidth, double screenHeight) {
    return Positioned(
      left: 20.0,
      top: 625.0,
      child: ErrorBoundary(
        child: GestureDetector(
          onTap: () {
            // Navigate to home screen after connecting
            context.go(RouteNames.home);
          },
          child: Container(
            width: screenWidth - 40.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(19, 166, 222, 1.0), // #13a6de
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
              child: Text(
                "Connect",
                style: GoogleFonts.inter(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ), 
    );
  }

  Widget _buildStartWithoutBluetoothLink(BuildContext context, double screenWidth, double screenHeight) {
    return Positioned(
      left: 20.0,
      top: 705.0,
      child: ErrorBoundary(
        child: GestureDetector(
          onTap: () {
            // Navigate to home screen
            context.go(RouteNames.home);
          },
          child: SizedBox(
            width: screenWidth - 40.0,
            child: Text(
              "Start Without Bluetooth",
              style: GoogleFonts.inter(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(19, 166, 222, 1.0), // #13a6de
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Large Bluetooth Icon Painter (380x380)
class LargeBluetoothIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(19, 166, 222, 1.0) // #13A6DE
      ..style = PaintingStyle.fill;

    final path = Path();
    // Large Bluetooth icon path from SVG
    path.moveTo(240.92, 126.991);
    path.lineTo(209.083, 158.828);
    path.lineTo(208.857, 95);
    path.lineTo(240.92, 126.991);
    path.close();

    path.moveTo(208.846, 290.118);
    path.lineTo(240.837, 258.127);
    path.lineTo(209, 226.29);
    path.lineTo(208.846, 290.118);
    path.close();

    path.moveTo(332.5, 192.518);
    path.cubicTo(332.5, 345.111, 279.134, 380, 195.118, 380);
    path.cubicTo(111.103, 380, 47.5, 345.111, 47.5, 192.518);
    path.cubicTo(47.5, 39.9237, 109.392, 0, 193.42, 0);
    path.cubicTo(277.448, 0, 332.5, 40.0069, 332.5, 192.518);
    path.close();

    path.moveTo(214.866, 192.518);
    path.lineTo(273.79, 126.766);
    path.lineTo(180.939, 27.0869);
    path.lineTo(180.939, 158.377);
    path.lineTo(126.16, 103.609);
    path.lineTo(106.115, 123.571);
    path.lineTo(174.919, 192.589);
    path.lineTo(106.115, 261.618);
    path.lineTo(126.077, 281.58);
    path.lineTo(180.856, 226.812);
    path.lineTo(182.566, 352.984);
    path.lineTo(277.115, 258.353);
    path.lineTo(214.866, 192.518);
    path.close();

    // Scale path from 380x380 SVG to actual size
    final scale = size.width / 380.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Header Bluetooth Icon Painter (50x50 scaled version)
class HeaderBluetoothIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Scale from 120x130 SVG to 50x50 widget
    final scale = size.width / 120.0;

    canvas.save();
    canvas.scale(scale);

    // Drop shadow (scaled)
    final shadowPaint = Paint()
      ..color = const Color.fromARGB(255, 8, 8, 8).withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0);

    canvas.drawCircle(
      Offset(45.0 - 1, 55.0 - 1.5),
      25.0,
      shadowPaint,
    );

    // Main circle with gradient fill
    final fillGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(35, 41, 46, 1.0), // #23292E
        Color.fromRGBO(26, 29, 31, 1.0), // #1A1D1F
      ],
    );

    final fillPaint = Paint()
      ..shader = fillGradient.createShader(
        Rect.fromCircle(center: Offset(45.0, 55.0), radius: 25.0),
      );

    canvas.drawCircle(
      Offset(45.0, 55.0),
      25.0,
      fillPaint,
    );

    // Stroke circle with gradient
    final strokeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(51, 59, 64, 1.0), // #333B40
        Color.fromRGBO(12, 14, 15, 1.0), // #0C0E0F
      ],
    );

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..shader = strokeGradient.createShader(
        Rect.fromCircle(center: Offset(45.0, 55.0), radius: 23.0),
      );

    canvas.drawCircle(
      Offset(45.0, 55.0),
      23.0,
      strokePaint,
    );

    // Bluetooth icon paths (white) - using original coordinates
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // First Bluetooth symbol part (top)
    path.moveTo(44.0955, 46.941);
    path.cubicTo(44.3072, 46.8351, 44.5606, 46.858, 44.75, 47);
    path.lineTo(49.75, 50.75);
    path.cubicTo(49.9074, 50.868, 50, 51.0533, 50, 51.25);
    path.cubicTo(50, 51.4467, 49.9074, 51.632, 49.75, 51.75);
    path.lineTo(44.75, 55.5);
    path.cubicTo(44.5606, 55.642, 44.3072, 55.6649, 44.0955, 55.559);
    path.cubicTo(43.8838, 55.4531, 43.75, 55.2367, 43.75, 55);
    path.lineTo(43.75, 47.5);
    path.cubicTo(43.75, 47.2633, 43.8838, 47.0469, 44.0955, 46.941);
    path.close();
    path.moveTo(45, 48.75);
    path.lineTo(45, 53.75);
    path.lineTo(48.3333, 51.25);
    path.lineTo(45, 48.75);
    path.close();

    // Second Bluetooth symbol part (bottom)
    path.moveTo(44.0955, 54.441);
    path.cubicTo(44.3072, 54.3351, 44.5606, 54.358, 44.75, 54.5);
    path.lineTo(49.75, 58.25);
    path.cubicTo(49.9074, 58.368, 50, 58.5533, 50, 58.75);
    path.cubicTo(50, 58.9467, 49.9074, 59.132, 49.75, 59.25);
    path.lineTo(44.75, 63);
    path.cubicTo(44.5606, 63.142, 44.3072, 63.1649, 44.0955, 63.059);
    path.cubicTo(43.8838, 62.9531, 43.75, 62.7367, 43.75, 62.5);
    path.lineTo(43.75, 55);
    path.cubicTo(43.75, 54.7633, 43.8838, 54.5469, 44.0955, 54.441);
    path.close();
    path.moveTo(45, 56.25);
    path.lineTo(45, 61.25);
    path.lineTo(48.3333, 58.75);
    path.lineTo(45, 56.25);
    path.close();

    // Left connecting lines
    path.moveTo(38.875, 50.875);
    path.cubicTo(39.0821, 50.5989, 39.4739, 50.5429, 39.75, 50.75);
    path.lineTo(44.75, 54.5);
    path.cubicTo(45.0262, 54.7071, 45.0821, 55.0989, 44.875, 55.375);
    path.cubicTo(44.6679, 55.6511, 44.2762, 55.7071, 44, 55.5);
    path.lineTo(39, 51.75);
    path.cubicTo(38.7239, 51.5429, 38.6679, 51.1511, 38.875, 50.875);
    path.close();

    path.moveTo(44.875, 54.625);
    path.cubicTo(45.0821, 54.9011, 45.0262, 55.2929, 44.75, 55.5);
    path.lineTo(39.75, 59.25);
    path.cubicTo(39.4739, 59.4571, 39.0821, 59.4011, 38.875, 59.125);
    path.cubicTo(38.6679, 58.8489, 38.7239, 58.4571, 39, 58.25);
    path.lineTo(44, 54.5);
    path.cubicTo(44.2762, 54.2929, 44.6679, 54.3489, 44.875, 54.625);
    path.close();

    canvas.drawPath(path, iconPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
