import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/error_boundary.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Navigate based on index
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        // Location/Map screen - navigate if exists
        break;
      case 2:
        // Car/Vehicle screen - navigate if exists
        break;
      case 3:
        context.go(RouteNames.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ErrorBoundary(
        child: AppBackground(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ErrorBoundary(
                      child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.85,
                        child: Stack(
                          children: [
                            _buildBluetoothIcon(context, screenWidth),
                            _buildTitleDescription(screenWidth),
                            _buildNotificationIcon(screenWidth),
                            _buildGradientEllipse(screenWidth),
                            _buildConcentricCircles(screenWidth),
                            _buildCarImage(screenWidth),
                            _buildPowerButton(screenWidth),
                            _buildStatusIndicators(screenWidth),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AppBottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _onNavItemTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBluetoothIcon(BuildContext context, double screenWidth) {
    return Positioned(
      left: -5.0,
      top: 9.0,
      child: ErrorBoundary(
        child: GestureDetector(
          onTap: () {
            // Navigate to Bluetooth connect screen
            context.go(RouteNames.bluetoothConnect);
          },
          child: SizedBox(
            width: 130.0,
            height: 130.0,
            child: CustomPaint(
              painter: BluetoothButtonPainter(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleDescription(double screenWidth) {
    return Positioned(
      top: 30.0,
      left: 0.0,
      right: 0.0,
      child: ErrorBoundary(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ErrorBoundary(
              child: Text(
                "Mitsubishi X2",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  decoration: TextDecoration.none,
                  fontSize: 21.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.0),
            ErrorBoundary(
              child: Text(
                "Parked",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  color: Color.fromRGBO(214, 214, 214, 1.0),
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(double screenWidth) {
    return Positioned(
      right: 28.0,
      top: 47.0,
      child: ErrorBoundary(
        child: GestureDetector(
          onTap: () {
            // Handle notification button tap
          },
          child: CustomPaint(
            size: Size(32.0, 32.0),
            painter: NotificationIconPainter(),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientEllipse(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - 259.5,
      bottom: - 270.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: 519.0,
          height: 543.0,
          child: CustomPaint(
            painter: GradientEllipsePainter(),
          ),
        ),
      ),
    );
  }

  Widget _buildConcentricCircles(double screenWidth) {
    // final centerX = screenWidth / 2;
    // final centerY = 280.0;

    return Positioned(
      // left: centerX - 160.0,
      // top: centerY - 190.0,
      child: ErrorBoundary(
        child: Stack(
          children: [
            // Outer circle
            Positioned(
                left: 76.0,
                top: 165.0,
                child: Container(
                  width: 260.0,
                  height: 260.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromRGBO(33, 150, 243, 0.3),
                      width: 2.0,
                    ),
                  ),
                )),
            // Middle circle
            Positioned(
              left: 50.0,
              top: 139,
              child: Container(
                width: 310.0,
                height: 310.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromRGBO(33, 150, 243, 0.4),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            // Inner solid circle
            Positioned(
              left: 103.0,
              top: 195.0,
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(13, 146, 255, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(35, 156, 255, 0.62),
                      blurRadius: 40.0,
                      spreadRadius: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarImage(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - 93,
      top: 108.0,
      child: ErrorBoundary(
        child: Container(
          height: 350.0,
          width: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/car.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPowerButton(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - 85,
      top: 500.0,
      child: ErrorBoundary(
        child: GestureDetector(
          onTap: () {
            // Handle power button tap
          },
          child: SizedBox(
            width: 191.0,
            height: 190.0,
            child: CustomPaint(
              painter: PowerButtonPainter(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicators(double screenWidth) {
    return Positioned(
      left: 20.0,
      top: 650.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: screenWidth - 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBatteryIndicator(),
              _buildTemperatureIndicator(),
              _buildRangeIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryIndicator() {
    return ErrorBoundary(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gradient ring with CustomPaint - size matches SizedBox
            CustomPaint(
              size: Size(100.0, 100.0),
              painter: BatteryRingPainter(),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  size: Size(30.0, 30.0),
                  painter: BatteryIconPainter(),
                ),
                SizedBox(height: 4.0),
                Text(
                  "48%",
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureIndicator() {
    return ErrorBoundary(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gradient ring with CustomPaint
            CustomPaint(
              size: Size(100.0, 100.0),
              painter: TemperatureRingPainter(),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  size: Size(30.0, 30.0),
                  painter: ThermometerIconPainter(),
                ),
                SizedBox(height: 4.0),
                Text(
                  "25",
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeIndicator() {
    return ErrorBoundary(
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gradient ring with CustomPaint
            CustomPaint(
              size: Size(100.0, 100.0),
              painter: RangeRingPainter(),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  size: Size(30.0, 30.0),
                  painter: RangeIconPainter(),
                ),
                SizedBox(height: 4.0),
                Text(
                  "300km",
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class BluetoothButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = 55.0;
    final centerY = 55.0;
    final radius = 25.0;
    final strokeRadius = 23.0;
    final strokeWidth = 4.0;

    // Drop shadow
    final shadowPaint = Paint()
      ..color = const Color.fromARGB(255, 8, 8, 8).withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);

    canvas.drawCircle(
      Offset(centerX - 1, centerY - 1.5),
      radius,
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
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      );

    canvas.drawCircle(
      Offset(centerX, centerY),
      radius,
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
      ..strokeWidth = strokeWidth
      ..shader = strokeGradient.createShader(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: strokeRadius),
      );

    canvas.drawCircle(
      Offset(centerX, centerY),
      strokeRadius,
      strokePaint,
    );

    // Bluetooth icon paths (white)
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // First Bluetooth symbol part (top)
    path.moveTo(54.0955, 46.941);
    path.cubicTo(54.3072, 46.8351, 54.5606, 46.858, 54.75, 47);
    path.lineTo(59.75, 50.75);
    path.cubicTo(59.9074, 50.868, 60, 51.0533, 60, 51.25);
    path.cubicTo(60, 51.4467, 59.9074, 51.632, 59.75, 51.75);
    path.lineTo(54.75, 55.5);
    path.cubicTo(54.5606, 55.642, 54.3072, 55.6649, 54.0955, 55.559);
    path.cubicTo(53.8838, 55.4531, 53.75, 55.2367, 53.75, 55);
    path.lineTo(53.75, 47.5);
    path.cubicTo(53.75, 47.2633, 53.8838, 47.0469, 54.0955, 46.941);
    path.close();
    path.moveTo(55, 48.75);
    path.lineTo(55, 53.75);
    path.lineTo(58.3333, 51.25);
    path.lineTo(55, 48.75);
    path.close();

    // Second Bluetooth symbol part (bottom)
    path.moveTo(54.0955, 54.441);
    path.cubicTo(54.3072, 54.3351, 54.5606, 54.358, 54.75, 54.5);
    path.lineTo(59.75, 58.25);
    path.cubicTo(59.9074, 58.368, 60, 58.5533, 60, 58.75);
    path.cubicTo(60, 58.9467, 59.9074, 59.132, 59.75, 59.25);
    path.lineTo(54.75, 63);
    path.cubicTo(54.5606, 63.142, 54.3072, 63.1649, 54.0955, 63.059);
    path.cubicTo(53.8838, 62.9531, 53.75, 62.7367, 53.75, 62.5);
    path.lineTo(53.75, 55);
    path.cubicTo(53.75, 54.7633, 53.8838, 54.5469, 54.0955, 54.441);
    path.close();
    path.moveTo(55, 56.25);
    path.lineTo(55, 61.25);
    path.lineTo(58.3333, 58.75);
    path.lineTo(55, 56.25);
    path.close();

    // Left connecting lines
    path.moveTo(48.875, 50.875);
    path.cubicTo(49.0821, 50.5988, 49.4739, 50.5429, 49.75, 50.75);
    path.lineTo(54.75, 54.5);
    path.cubicTo(55.0262, 54.7071, 55.0821, 55.0988, 54.875, 55.375);
    path.cubicTo(54.6679, 55.6511, 54.2762, 55.7071, 54, 55.5);
    path.lineTo(49, 51.75);
    path.cubicTo(48.7239, 51.5429, 48.6679, 51.1511, 48.875, 50.875);
    path.close();

    path.moveTo(54.875, 54.625);
    path.cubicTo(55.0821, 54.9011, 55.0262, 55.2929, 54.75, 55.5);
    path.lineTo(49.75, 59.25);
    path.cubicTo(49.4739, 59.4571, 49.0821, 59.4011, 48.875, 59.125);
    path.cubicTo(48.6679, 58.8488, 48.7239, 58.4571, 49, 58.25);
    path.lineTo(54, 54.5);
    path.cubicTo(54.2762, 54.2929, 54.6679, 54.3488, 54.875, 54.625);
    path.close();

    canvas.drawPath(path, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PowerButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = 85.0645;
    final centerY = 74.6753;
    final outerRadius = 42.0; // Reduced from 44.0 to make ring thinner
    final ellipseRx = 35.0649;
    final ellipseRy = 34.6753;
    final innerRadius = 29.6758;

    // Outer stroke path with gradient
    final outerStrokeGradient = LinearGradient(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(21, 157, 255, 0.075), // #0095FF with 0 opacity
        Color.fromRGBO(7, 117, 196, 0.882), // #0095FF
      ],
    );

    final outerStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 // Reduced stroke width to make ring thinner
      ..shader = outerStrokeGradient.createShader(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: outerRadius),
      );

    canvas.drawCircle(
      Offset(centerX, centerY),
      outerRadius,
      outerStrokePaint,
    );

    // Main ellipse with gradient fill
    final ellipseFillGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(0, 111, 190, 1.0), // #006FBE
        Color.fromRGBO(48, 168, 254, 1.0), // #30A8FE
      ],
    );

    final ellipseFillPaint = Paint()
      ..shader = ellipseFillGradient.createShader(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: ellipseRx * 2,
          height: ellipseRy * 2,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: ellipseRx * 2,
        height: ellipseRy * 2,
      ),
      ellipseFillPaint,
    );

    // Inner stroke path with gradient
    final innerStrokeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(20, 135, 218, 1.0), // #1487DA
        Color.fromRGBO(4, 115, 195, 1.0), // #0473C3
      ],
    );

    final innerStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..shader = innerStrokeGradient.createShader(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: innerRadius),
      );

    canvas.drawCircle(
      Offset(centerX, centerY),
      innerRadius,
      innerStrokePaint,
    );

    // White power icon
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // Vertical line
    path.moveTo(85.0651, 65.1396);
    path.cubicTo(85.5492, 65.1396, 85.9417, 65.5277, 85.9417, 66.0065);
    path.lineTo(85.9417, 74.2419);
    path.cubicTo(85.9417, 74.7206, 85.5492, 75.1088, 85.0651, 75.1088);
    path.cubicTo(84.581, 75.1088, 84.1885, 74.7206, 84.1885, 74.2419);
    path.lineTo(84.1885, 66.0065);
    path.cubicTo(84.1885, 65.5277, 84.581, 65.1396, 85.0651, 65.1396);
    path.close();

    // Circle base
    path.moveTo(80.5404, 66.2055);
    path.cubicTo(80.8045, 66.6068, 80.6896, 67.1437, 80.2838, 67.4049);
    path.cubicTo(78.6999, 68.4242, 77.4915, 69.9224, 76.8388, 71.6761);
    path.cubicTo(76.186, 73.4298, 76.1238, 75.3452, 76.6614, 77.1367);
    path.cubicTo(77.199, 78.9283, 78.3076, 80.5, 79.822, 81.6178);
    path.cubicTo(81.3365, 82.7355, 83.1756, 83.3394, 85.0654, 83.3394);
    path.cubicTo(86.9551, 83.3394, 88.7943, 82.7355, 90.3087, 81.6178);
    path.cubicTo(91.8232, 80.5, 92.9318, 78.9283, 93.4694, 77.1367);
    path.cubicTo(94.007, 75.3452, 93.9448, 73.4298, 93.292, 71.6761);
    path.cubicTo(92.6392, 69.9224, 91.4308, 68.4242, 89.847, 67.4049);
    path.cubicTo(89.4412, 67.1437, 89.3263, 66.6068, 89.5904, 66.2055);
    path.cubicTo(89.8545, 65.8042, 90.3975, 65.6906, 90.8033, 65.9518);
    path.cubicTo(92.7039, 67.1749, 94.154, 68.9727, 94.9373, 71.0772);
    path.cubicTo(95.7207, 73.1817, 95.7953, 75.4801, 95.1502, 77.6299);
    path.cubicTo(94.5051, 79.7798, 93.1747, 81.6659, 91.3574, 83.0072);
    path.cubicTo(89.5401, 84.3485, 87.3331, 85.0732, 85.0654, 85.0732);
    path.cubicTo(82.7977, 85.0732, 80.5907, 84.3485, 78.7734, 83.0072);
    path.cubicTo(76.956, 81.6659, 75.6257, 79.7798, 74.9805, 77.6299);
    path.cubicTo(74.3354, 75.4801, 74.4101, 73.1817, 75.1934, 71.0772);
    path.cubicTo(75.9768, 68.9727, 77.4268, 67.1749, 79.3275, 65.9518);
    path.cubicTo(79.7333, 65.6906, 80.2763, 65.8042, 80.5404, 66.2055);
    path.close();

    canvas.drawPath(path, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GradientEllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 519.0;
    final height = 443.0;

    // Create the ellipse path
    final path = Path();
    path.moveTo(650, 271.5);
    path.cubicTo(519, 421.445, 402.818, 543, 259.5, 543);
    path.cubicTo(216.182, 543, 0, 421.445, 0, 271.5);
    path.cubicTo(0, 121.555, 116.182, 0, 259.5, 0);
    path.cubicTo(402.818, 0, 519, 121.555, 519, 271.5);
    path.close();

    // Create linear gradient: darker at top, more transparent at bottom
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color.fromARGB(186, 8, 8, 8).withOpacity(0.73), // Darker at top
        const Color.fromARGB(255, 22, 21, 21).withOpacity(0.3), // Lighter/transparent at bottom
      ],
      stops: [0.0,2.0], // Full fade from top to bottom
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, width, height),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Battery Ring Painter - Green to Yellow gradient (top to bottom)
// class BatteryRingPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final strokeWidth = 4.0;
//     // Adjust radius to prevent clipping - account for stroke width
//     final radius = (size.width / 2) - (strokeWidth / 2);

//     // Gradient: #85FF83 (transparent) → #FFE483 (yellow)
    // Direction: top to bottom (x1="50" y1="-20" x2="50" y2="100")
//     final gradient = LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         const Color(0xFF85FF83).withOpacity(0.0), // Transparent at top
//         const Color(0xFFFFE483), // Yellow at bottom
//       ],
//       stops: [0.0, 1.0],
//     );

//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..shader = gradient.createShader(
//         Rect.fromCircle(center: center, radius: radius),
//       );

//     canvas.drawCircle(center, radius, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }



// Temperature Ring Painter - Light Blue gradient (diagonal)
class BatteryRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = 4.0;
    // Adjust radius to prevent clipping - account for stroke width
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Gradient: #83E9FF (transparent) → #83E1FF (light blue)
    // Direction: diagonal (x1="2.69048" y1="-8.5" x2="91.6667" y2="80.4762")
    final gradient = LinearGradient(
      end: Alignment.bottomRight,
      begin: Alignment.topLeft,
      colors: [
        const Color(0xFF85FF83).withOpacity(0.0), // Transparent at top
        const Color(0xFFFFE483), // / Light blue at bottom-right
      ],
      stops: [0.0, 1.0],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// Temperature Ring Painter - Light Blue gradient (diagonal)
class TemperatureRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = 4.0;
    // Adjust radius to prevent clipping - account for stroke width
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Gradient: #83E9FF (transparent) → #83E1FF (light blue)
    // Direction: diagonal (x1="2.69048" y1="-8.5" x2="91.6667" y2="80.4762")
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.centerLeft,
      colors: [
        const Color(0xFF83E9FF).withOpacity(0.0), // Transparent at top-left
        const Color(0xFF83E1FF), // Light blue at bottom-right
      ],
      stops: [0.0, 1.0],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Range Ring Painter - Red gradient (diagonal)
class RangeRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = 4.0;
    // Adjust radius to prevent clipping - account for stroke width
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Gradient: #FF8383 (transparent) → #FF8383 (red)
    // Direction: diagonal (x1="99.0714" y1="14.5" x2="22.1429" y2="91.4286")
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        const Color(0xFFFF8383).withOpacity(0.0), // Transparent at top-right
        const Color(0xFFFF8383), // Red at bottom-left
      ],
      stops: [0.0, 1.0],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Battery Icon Painter - SVG path from HTML
class BatteryIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Battery icon paths from SVG
    path.moveTo(10.3125, 0.937501);
    path.cubicTo(10.3125, 0.419734, 10.7322, 0, 11.25, 0);
    path.lineTo(18.75, 0);
    path.cubicTo(19.2678, 0, 19.6875, 0.419734, 19.6875, 0.937501);
    path.cubicTo(19.6875, 1.45527, 19.2678, 1.875, 18.75, 1.875);
    path.lineTo(11.25, 1.875);
    path.cubicTo(10.7322, 1.875, 10.3125, 1.45527, 10.3125, 0.937501);
    path.close();

    path.moveTo(8.4375, 5.625);
    path.cubicTo(7.91973, 5.625, 7.5, 6.04473, 7.5, 6.5625);
    path.lineTo(7.5, 24.375);
    path.cubicTo(7.5, 24.8928, 7.91974, 25.3125, 8.4375, 25.3125);
    path.lineTo(21.5625, 25.3125);
    path.cubicTo(22.0803, 25.3125, 22.5, 24.8928, 22.5, 24.375);
    path.lineTo(22.5, 6.5625);
    path.cubicTo(22.5, 6.04473, 22.0803, 5.625, 21.5625, 5.625);
    path.lineTo(8.4375, 5.625);
    path.close();

    path.moveTo(5.625, 6.5625);
    path.cubicTo(5.625, 5.0092, 6.8842, 3.75, 8.4375, 3.75);
    path.lineTo(21.5625, 3.75);
    path.cubicTo(23.1158, 3.75, 24.375, 5.0092, 24.375, 6.5625);
    path.lineTo(24.375, 24.375);
    path.cubicTo(24.375, 25.9283, 23.1158, 27.1875, 21.5625, 27.1875);
    path.lineTo(8.4375, 27.1875);
    path.cubicTo(6.8842, 27.1875, 5.625, 25.9283, 5.625, 24.375);
    path.lineTo(5.625, 6.5625);
    path.close();

    path.moveTo(9.375, 17.625);
    path.cubicTo(9.375, 17.1072, 9.79473, 16.6875, 10.3125, 16.6875);
    path.lineTo(19.6875, 16.6875);
    path.cubicTo(20.2053, 16.6875, 20.625, 17.1072, 20.625, 17.625);
    path.cubicTo(20.625, 18.1428, 20.2053, 18.5625, 19.6875, 18.5625);
    path.lineTo(10.3125, 18.5625);
    path.cubicTo(9.79473, 18.5625, 9.375, 18.1428, 9.375, 17.625);
    path.close();

    path.moveTo(9.375, 21.9375);
    path.cubicTo(9.375, 21.4197, 9.79473, 21, 10.3125, 21);
    path.lineTo(19.6875, 21);
    path.cubicTo(20.2053, 21, 20.625, 21.4197, 20.625, 21.9375);
    path.cubicTo(20.625, 22.4553, 20.2053, 22.875, 19.6875, 22.875);
    path.lineTo(10.3125, 22.875);
    path.cubicTo(9.79473, 22.875, 9.375, 22.4553, 9.375, 21.9375);
    path.close();

    // Scale path from 30x30 SVG to actual size
    final scale = size.width / 30.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Thermometer Icon Painter - SVG path from HTML
class ThermometerIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Thermometer icon paths from SVG
    path.moveTo(24.8438, 7.96875);
    path.cubicTo(24.0671, 7.96875, 23.4375, 8.59835, 23.4375, 9.375);
    path.cubicTo(23.4375, 10.1517, 24.0671, 10.7812, 24.8438, 10.7812);
    path.cubicTo(25.6204, 10.7812, 26.25, 10.1517, 26.25, 9.375);
    path.cubicTo(26.25, 8.59835, 25.6204, 7.96875, 24.8438, 7.96875);
    path.close();

    path.moveTo(21.5625, 9.375);
    path.cubicTo(21.5625, 7.56282, 23.0316, 6.09375, 24.8438, 6.09375);
    path.cubicTo(26.6559, 6.09375, 28.125, 7.56282, 28.125, 9.375);
    path.cubicTo(28.125, 11.1872, 26.6559, 12.6562, 24.8438, 12.6562);
    path.cubicTo(23.0316, 12.6562, 21.5625, 11.1872, 21.5625, 9.375);
    path.close();

    path.moveTo(14.0625, 2.8125);
    path.cubicTo(13.3166, 2.8125, 12.6012, 3.10882, 12.0738, 3.63626);
    path.cubicTo(11.5463, 4.16371, 11.25, 4.87908, 11.25, 5.625);
    path.lineTo(11.25, 17.2266);
    path.lineTo(10.3125, 17.2266);
    path.cubicTo(10.0431, 18.6262, 9.42418, 19.5347, 9.11897, 20.5641);
    path.cubicTo(8.81376, 21.5934, 8.8375, 22.6924, 9.18688, 23.7077);
    path.cubicTo(9.53625, 24.7229, 10.1938, 25.6038, 11.0679, 26.2273);
    path.cubicTo(11.9419, 26.8509, 12.9888, 27.1861, 14.0625, 27.1861);
    path.cubicTo(15.1362, 27.1861, 16.1831, 26.8509, 17.0571, 26.2273);
    path.cubicTo(17.9312, 25.6038, 18.5887, 24.7229, 18.9381, 23.7077);
    path.cubicTo(19.2875, 22.6924, 19.3112, 21.5934, 19.006, 20.5641);
    path.cubicTo(18.7008, 19.5347, 18.0819, 18.6262, 17.2356, 17.9655);
    path.lineTo(16.875, 17.2266);
    path.lineTo(16.875, 5.625);
    path.cubicTo(16.875, 4.87908, 16.5787, 4.16371, 16.0512, 3.63626);
    path.cubicTo(15.5238, 3.10882, 14.8084, 2.8125, 14.0625, 2.8125);
    path.close();

    path.moveTo(9.375, 16.789);
    path.lineTo(9.375, 5.625);
    path.cubicTo(9.375, 4.3818, 9.86886, 3.18951, 10.7479, 2.31044);
    path.cubicTo(11.627, 1.43136, 12.8193, 0.9375, 14.0625, 0.9375);
    path.cubicTo(15.3057, 0.9375, 16.498, 1.43136, 17.3771, 2.31044);
    path.cubicTo(18.2561, 3.18951, 18.75, 4.3818, 18.75, 5.625);
    path.lineTo(18.75, 16.789);
    path.cubicTo(19.7196, 17.6563, 20.4321, 18.778, 20.8037, 20.0311);
    path.cubicTo(21.2199, 21.4348, 21.1875, 22.9334, 20.7111, 24.3178);
    path.cubicTo(20.2347, 25.7022, 19.3379, 26.9034, 18.1461, 27.7537);
    path.cubicTo(16.9542, 28.604, 15.5266, 29.0611, 14.0625, 29.0611);
    path.cubicTo(12.5984, 29.0611, 11.1708, 28.604, 9.97893, 27.7537);
    path.cubicTo(8.78705, 26.9034, 7.89034, 25.7022, 7.41392, 24.3178);
    path.cubicTo(6.9375, 22.9334, 6.90513, 21.4348, 7.32133, 20.0311);
    path.cubicTo(7.69287, 18.778, 8.40536, 17.6563, 9.375, 16.789);
    path.close();

    path.moveTo(14.0625, 20.625);
    path.cubicTo(13.2858, 20.625, 12.6562, 21.2546, 12.6562, 22.0312);
    path.cubicTo(12.6562, 22.8079, 13.2858, 23.4375, 14.0625, 23.4375);
    path.cubicTo(14.8392, 23.4375, 15.4688, 22.8079, 15.4688, 22.0312);
    path.cubicTo(15.4688, 21.2546, 14.8392, 20.625, 14.0625, 20.625);
    path.close();

    path.moveTo(10.7812, 22.0312);
    path.cubicTo(10.7812, 20.2191, 12.2503, 18.75, 14.0625, 18.75);
    path.cubicTo(15.8747, 18.75, 17.3438, 20.2191, 17.3438, 22.0312);
    path.cubicTo(17.3438, 23.8434, 15.8747, 25.3125, 14.0625, 25.3125);
    path.cubicTo(12.2503, 25.3125, 10.7812, 23.8434, 10.7812, 22.0312);
    path.close();

    path.moveTo(14.0625, 9.375);
    path.cubicTo(14.5803, 9.375, 15, 9.79473, 15, 10.3125);
    path.lineTo(15, 19.6875);
    path.cubicTo(15, 20.2053, 14.5803, 20.625, 14.0625, 20.625);
    path.cubicTo(13.5447, 20.625, 13.125, 20.2053, 13.125, 19.6875);
    path.lineTo(13.125, 10.3125);
    path.cubicTo(13.125, 9.79473, 13.5447, 9.375, 14.0625, 9.375);
    path.close();

    // Scale path from 30x30 SVG to actual size
    final scale = size.width / 30.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Range Icon Painter - SVG path from HTML (navigation arrow)
class RangeIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Navigation arrow icon paths from SVG
    path.moveTo(5.88681, 3.49748);
    path.cubicTo(5.88763, 3.49776, 5.88845, 3.49805, 5.88927, 3.49834);
    path.lineTo(25.722, 10.3631);
    path.cubicTo(27.4552, 10.958, 27.3739, 13.3942, 25.6614, 13.9265);
    path.lineTo(16.6946, 16.6927);
    path.lineTo(13.9275, 25.6588);
    path.cubicTo(13.3945, 27.3736, 10.9583, 27.4549, 10.3639, 25.7231);
    path.lineTo(3.49865, 5.88896);
    path.cubicTo(3.38138, 5.55381, 3.3611, 5.19502, 3.4393, 4.8513);
    path.cubicTo(3.5177, 4.50673, 3.69188, 4.19132, 3.94175, 3.94145);
    path.cubicTo(4.19163, 3.69157, 4.50703, 3.5174, 4.8516, 3.439);
    path.cubicTo(5.19533, 3.36079, 5.55411, 3.38107, 5.88681, 3.49748);
    path.close();

    path.moveTo(4.38311, 5.57812);
    path.lineTo(5.26904, 5.27147);
    path.lineTo(12.1351, 25.1081);
    path.lineTo(14.8988, 16.1382);
    path.cubicTo(14.9859, 15.8395, 15.1483, 15.5681, 15.3705, 15.3501);
    path.cubicTo(15.5901, 15.1346, 15.8608, 14.9785, 16.157, 14.8964);
    path.lineTo(25.1049, 12.136);
    path.lineTo(5.26757, 5.26728);
    path.lineTo(4.38311, 5.57812);
    path.close();

    // Scale path from 30x30 SVG to actual size
    final scale = size.width / 30.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Notification Icon Painter - Bell icon from SVG
class NotificationIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // Notification bell icon path from SVG
    path.moveTo(18.1337, 26.6667);
    path.lineTo(13.867, 26.6667);
    path.moveTo(22.667, 13.3333);
    path.cubicTo(22.667, 9.65199, 19.6817, 6.66666, 16.0003, 6.66666);
    path.cubicTo(12.319, 6.66666, 9.33366, 9.65199, 9.33366, 13.3333);
    path.lineTo(9.33366, 16.672);
    path.cubicTo(9.33366, 17.104, 9.08966, 17.4973, 8.70433, 17.6907);
    path.lineTo(8.03366, 18.0253);
    path.cubicTo(7.19633, 18.4453, 6.66699, 19.3013, 6.66699, 20.2373);
    path.cubicTo(6.66699, 21.6027, 7.77366, 22.7093, 9.13899, 22.7093);
    path.lineTo(22.8617, 22.7093);
    path.cubicTo(24.227, 22.7093, 25.3337, 21.6027, 25.3337, 20.2373);
    path.cubicTo(25.3337, 19.3013, 24.8043, 18.4453, 23.967, 18.0267);
    path.lineTo(23.2963, 17.692);
    path.cubicTo(22.911, 17.4973, 22.667, 17.104, 22.667, 16.672);
    path.lineTo(22.667, 13.3333);
    path.close();

    // Scale path from 32x32 SVG to actual size
    final scale = size.width / 32.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
