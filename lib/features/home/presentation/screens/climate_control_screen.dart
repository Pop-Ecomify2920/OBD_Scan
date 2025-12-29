import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import '../../../../shared/widgets/error_boundary.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import 'home_screen.dart'; // For NotificationIconPainter and HeaderBluetoothIconPainter

class ClimateControlScreen extends StatefulWidget {
  const ClimateControlScreen({super.key});

  @override
  State<ClimateControlScreen> createState() => _ClimateControlScreenState();
}

class _ClimateControlScreenState extends State<ClimateControlScreen> {
  int _currentIndex = 0; // Home index (climate is part of home)

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.safety);
        break;
      case 2:
        context.go(RouteNames.vehicleStatus);
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
                    child: SizedBox(
                      width: screenWidth,
                      height: 772, // Increased height to show all elements including bottom controls
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Header section
                          _buildHeader(context, screenWidth),
                          // Temperature dial
                          _buildTemperatureDial(screenWidth, screenHeight),
                          // Bottom controls
                          _buildBottomControls(screenWidth, screenHeight),
                        ],
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

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Positioned(
      left: 0.0,
      top: 18.0,
      right: 0.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: screenWidth,
          height: 130.0,
          child: Stack(
            children: [
              // Bluetooth icon (left)
              Positioned(
                left: -5.0,
                top: 0.0,
                child: GestureDetector(
                  onTap: () {
                    // Navigate back to home screen
                    context.go(RouteNames.home);
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
              // Title and subtitle (center) - absolutely centered
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 10.0,
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
                right: 20.0,
                top: 37.0,
                child: GestureDetector(
                  onTap: () {
                    // Handle notification button tap
                  },
                  child: SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: CustomPaint(
                      painter: NotificationIconPainter(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureDial(double screenWidth, double screenHeight) {
    return Positioned(
      left: (screenWidth - 362.0) / 2,
      top: 110.0,
      child: ErrorBoundary(
        child: SizedBox(
          width: 362.0,
          height: 362.0,
          child: Stack(
            children: [
              // Outer circle dial
              CustomPaint(
                size: Size(362.0, 362.0),
                painter: TemperatureDialOuterPainter(),
              ),
              // Blur effects layers````````````````````````
              Positioned(
                left: -33,
                top: -36,
                child: CustomPaint(
                  size: Size(404.0, 425.0),
                  painter: TemperatureDialBlurPainter1(),
                ),
              ),
              Positioned(
                left: 76.57,
                top: 10,
                child: CustomPaint(
                  size: Size(391.0, 394.0),
                  // painter: TemperatureDialBlurPainter2(),
                ),
              ),
              // Main filled circle````````````````````````
              Positioned(
                left: 60,
                top: 60,
                child: CustomPaint(
                  size: Size(241.0, 241.0),
                  painter: TemperatureDialMainCirclePainter(),
                ),
              ),
              // Blue arc``````````````````````````````````
              Positioned(
                left: 73,
                top: 73,
                child: CustomPaint(
                  size: Size(154.0, 212.0),
                  painter: TemperatureDialArcPainter(),
                ),
              ),
              // Crosshair marks
              Positioned(
                left: (362.0 - 300.0) / 2,
                top: (362.0 - 300.0) / 2,
                child: CustomPaint(
                  size: Size(300.0, 300.0),
                  painter: TemperatureDialCrosshairPainter(),
                ),
              ),
              // Center dot``````````````````````````````
              Positioned(
                left: (408.0 - 30.14) / 2,
                top: (195.0 - 30.14) / 2,
                child: CustomPaint(
                  size: Size(30.14, 30.14),
                  painter: TemperatureDialCenterDotPainter(),
                ),
              ),
              // Temperature text
              Positioned(
                left: 140.0,
                top: 146.0,
                child: Text(
                  "25℃",
                  style: GoogleFonts.inter(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls(double screenWidth, double screenHeight) {
    // Position below the temperature dial (120 + 362 = 482, add some spacing)
    // From HTML: Heatings at left-0, Wind Speed at left-[103px], Refrigeration at left-[258px]
    // Center the entire group on screen
    final totalWidth = 258.0 + 105.0; // Right edge of refrigeration
    final groupLeft = (screenWidth - totalWidth) / 2;
    
    return Positioned(
      left: 0.0,
      top: 460.0, // Position below temperature dial``````````````````````````````````````````````````````
      child: ErrorBoundary(
        child: SizedBox(
          width: screenWidth,
          height: 300.0, // Ensure enough height for wind speed control (251px)
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Heatings button (left) - from HTML: left-0 top-[78.5px]
              Positioned(
                left: groupLeft - 23.0,
                top: 78.5,
                child: _buildHeatingsButton(),
              ),
              // Wind Speed control (center) - from HTML: left-[103px] top-0
              Positioned(
                left: groupLeft + 121.0,
                top: 40.0,
                child: _buildWindSpeedControl(),
              ),
              // Refrigeration button (right) - from HTML: left-[258px] top-[78.5px]
              Positioned(
                left: groupLeft + 258.0,
                top: 78.5,
                child: _buildRefrigerationButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeatingsButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          height: 150.0,
          child: CustomPaint(
            painter: HeatingsIconPainter(),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Heatings",
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildWindSpeedControl() {
    return Container(
      width: 124.0,
      height: 255.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(49, 49, 49, 1), // #242424
        borderRadius: BorderRadius.circular(272.0),
      ),
      child: Stack(
        children: [
          // Wind icon
          Positioned(
            left: 42.0,
            top: 70.0,
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CustomPaint(
                painter: WindIconPainter(),
              ),
            ),
          ),
          // Wind Speed text
          Positioned(
            left: 14.0,
            top: 40.0,
            child: Text(
              "WIND SPEED",
              style: GoogleFonts.inter(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          // Red circular dial
          Positioned(
            left: -47.5,
            top: 67.5,
            child: SizedBox(
              width: 220.0,
              height: 230.0,
              child: CustomPaint(
                painter: WindSpeedDialPainter(),
              ),
            ),
          ),
          // Percentage text
          Positioned(
            left: 30.0,
            top: 155.0,
            child: Text(
              "32%",
              style: GoogleFonts.inter(
                fontSize: 31.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefrigerationButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          height: 150.0,
          child: CustomPaint(
            painter: RefrigerationIconPainter(),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          "Refrigeration",
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

// Heatings Icon Painter (Sun icon)
class HeatingsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 160.0;
    final svgCenter = Offset(70.0, 70.0);

    canvas.save();
    canvas.scale(scale);


   final shadowPaint = Paint()
      ..color = Colors.black
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0);

    canvas.drawCircle(svgCenter, 30.0, shadowPaint);

    // Main circle
    final circlePaint = Paint()
      ..color = Color.fromRGBO(36, 36, 36, 1.0) // #242424
      ..style = PaintingStyle.fill;

    canvas.drawCircle(svgCenter, 30.0, circlePaint);

    // Sun icon paths (white)
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Center circle (outer ring)
    canvas.drawCircle(svgCenter, 8.5, iconPaint);
    // Center circle (inner, transparent)
    final innerPaint = Paint()
      ..color = Color.fromRGBO(36, 36, 36, 1.0)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(svgCenter, 6.5, innerPaint);

    // Draw rays as rectangles
    // Top
    canvas.drawRect(Rect.fromCenter(center: Offset(70.0, 57.25), width: 1.0, height: 4.5), iconPaint);
    // Right
    canvas.drawRect(Rect.fromCenter(center: Offset(57.75, 70.0), width: 4.5, height: 1.0), iconPaint);
    // Bottom
    canvas.drawRect(Rect.fromCenter(center: Offset(70.0, 82.75), width: 1.0, height: 4.5), iconPaint);
    // Left
    canvas.drawRect(Rect.fromCenter(center: Offset(82.25, 70.0), width: 4.5, height: 1.0), iconPaint);
    
    // Diagonal rays
    final diagonalPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    // Top-right
    canvas.drawLine(Offset(59.3925, 59.3929), Offset(62.5692, 62.5696), diagonalPaint);
    // Bottom-right
    canvas.drawLine(Offset(59.3925, 80.6071), Offset(62.5692, 77.4304), diagonalPaint);
    // Bottom-left
    canvas.drawLine(Offset(80.6073, 80.6071), Offset(77.4306, 77.4304), diagonalPaint);
    // Top-left
    canvas.drawLine(Offset(80.6073, 59.3929), Offset(77.4306, 62.5696), diagonalPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Wind Icon Painter
class WindIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(115, 132, 150, 1.0) // #738496
      ..style = PaintingStyle.fill;

    final path = Path();

    // Wind icon paths from SVG
    // First curved line (bottom)
    path.moveTo(23.7495, 23.75);
    path.cubicTo(24.6633, 23.7494, 25.5599, 23.9992, 26.3417, 24.4723);
    path.cubicTo(27.1237, 24.9455, 27.761, 25.6241, 28.1843, 26.4341);
    path.cubicTo(28.6077, 27.2442, 28.8009, 28.1548, 28.7429, 29.0669);
    path.cubicTo(28.685, 29.9791, 28.3781, 30.8579, 27.8557, 31.6079);
    path.cubicTo(27.3333, 32.3579, 26.6152, 32.9503, 25.7797, 33.3208);
    path.cubicTo(24.9441, 33.6913, 24.023, 33.8257, 23.1164, 33.7093);
    path.cubicTo(22.2099, 33.593, 21.3525, 33.2303, 20.6376, 32.6608);
    path.cubicTo(19.9227, 32.0913, 19.3776, 31.3368, 19.0615, 30.4792);
    path.cubicTo(18.8228, 29.8314, 19.1543, 29.1128, 19.8021, 28.874);
    path.cubicTo(20.4498, 28.6353, 21.1685, 28.9668, 21.4072, 29.6146);
    path.cubicTo(21.5653, 30.0434, 21.8379, 30.4207, 22.1953, 30.7054);
    path.cubicTo(22.5528, 30.9902, 22.9814, 31.1715, 23.4347, 31.2297);
    path.cubicTo(23.888, 31.2878, 24.3486, 31.2207, 24.7663, 31.0354);
    path.cubicTo(25.1841, 30.8502, 25.5431, 30.554, 25.8043, 30.179);
    path.cubicTo(26.0656, 29.804, 26.219, 29.3646, 26.248, 28.9085);
    path.cubicTo(26.2769, 28.4524, 26.1803, 27.9971, 25.9686, 27.5921);
    path.cubicTo(25.757, 27.187, 25.4383, 26.8478, 25.0473, 26.6112);
    path.cubicTo(24.6564, 26.3745, 24.208, 26.2496, 23.751, 26.25);
    path.lineTo(6.25, 26.25);
    path.cubicTo(5.55964, 26.25, 5, 25.6904, 5, 25);
    path.cubicTo(5, 24.3096, 5.55964, 23.75, 6.25, 23.75);
    path.lineTo(23.7495, 23.75);
    path.close();

    // Second curved line (middle)
    path.moveTo(19.7663, 8.96459);
    path.cubicTo(19.3486, 8.77935, 18.888, 8.71216, 18.4347, 8.77034);
    path.cubicTo(17.9814, 8.82852, 17.5528, 9.00984, 17.1953, 9.29459);
    path.cubicTo(16.8379, 9.57933, 16.5653, 9.95661, 16.4072, 10.3854);
    path.cubicTo(16.1685, 11.0332, 15.4498, 11.3647, 14.8021, 11.126);
    path.cubicTo(14.1543, 10.8872, 13.8228, 10.1686, 14.0615, 9.52083);
    path.cubicTo(14.3776, 8.66322, 14.9227, 7.90866, 15.6376, 7.33917);
    path.cubicTo(16.3525, 6.76968, 17.2099, 6.40705, 18.1164, 6.29069);
    path.cubicTo(19.023, 6.17433, 19.9441, 6.30869, 20.7797, 6.67918);
    path.cubicTo(21.6152, 7.04966, 22.3333, 7.64209, 22.8557, 8.39208);
    path.cubicTo(23.3781, 9.14206, 23.685, 10.0209, 23.7429, 10.9331);
    path.cubicTo(23.8009, 11.8452, 23.6077, 12.7558, 23.1843, 13.5659);
    path.cubicTo(22.761, 14.3759, 22.1237, 15.0545, 21.3417, 15.5277);
    path.cubicTo(20.56, 16.0007, 19.6637, 16.2505, 18.75, 16.25);
    path.lineTo(3.75, 16.25);
    path.cubicTo(3.05964, 16.25, 2.5, 15.6904, 2.5, 15);
    path.cubicTo(2.5, 14.3096, 3.05964, 13.75, 3.75, 13.75);
    path.lineTo(18.75, 13.75);
    path.cubicTo(19.207, 13.7504, 19.6564, 13.6255, 20.0473, 13.3888);
    path.cubicTo(20.4383, 13.1522, 20.757, 12.813, 20.9686, 12.4079);
    path.cubicTo(21.1803, 12.0029, 21.2769, 11.5476, 21.248, 11.0915);
    path.cubicTo(21.219, 10.6355, 21.0656, 10.196, 20.8043, 9.82104);
    path.cubicTo(20.5431, 9.44605, 20.1841, 9.14983, 19.7663, 8.96459);
    path.close();

    // Third curved line (top)
    path.moveTo(33.5163, 13.9646);
    path.cubicTo(33.0986, 13.7793, 32.638, 13.7122, 32.1847, 13.7703);
    path.cubicTo(31.7314, 13.8285, 31.3028, 14.0098, 30.9453, 14.2946);
    path.cubicTo(30.5879, 14.5793, 30.3153, 14.9566, 30.1572, 15.3854);
    path.cubicTo(29.9185, 16.0332, 29.1998, 16.3647, 28.5521, 16.126);
    path.cubicTo(27.9043, 15.8872, 27.5728, 15.1686, 27.8115, 14.5208);
    path.cubicTo(28.1276, 13.6632, 28.6727, 12.9087, 29.3876, 12.3392);
    path.cubicTo(30.1025, 11.7697, 30.9599, 11.407, 31.8664, 11.2907);
    path.cubicTo(32.773, 11.1743, 33.6941, 11.3087, 34.5297, 11.6792);
    path.cubicTo(35.3653, 12.0497, 36.0833, 12.6421, 36.6057, 13.3921);
    path.cubicTo(37.1281, 14.1421, 37.435, 15.0209, 37.4929, 15.9331);
    path.cubicTo(37.5509, 16.8452, 37.3577, 17.7558, 36.9343, 18.5659);
    path.cubicTo(36.511, 19.3759, 35.8737, 20.0545, 35.0917, 20.5277);
    path.cubicTo(34.31, 21.0008, 33.4136, 21.2506, 32.4998, 21.25);
    path.lineTo(5, 21.25);
    path.cubicTo(4.30964, 21.25, 3.75, 20.6904, 3.75, 20);
    path.cubicTo(3.75, 19.3096, 4.30964, 18.75, 5, 18.75);
    path.lineTo(32.5, 18.75);
    path.cubicTo(32.957, 18.7504, 33.4064, 18.6255, 33.7973, 18.3888);
    path.cubicTo(34.1883, 18.1522, 34.507, 17.813, 34.7187, 17.4079);
    path.cubicTo(34.9303, 17.0029, 35.0269, 16.5476, 34.998, 16.0915);
    path.cubicTo(34.969, 15.6354, 34.8156, 15.196, 34.5543, 14.821);
    path.cubicTo(34.2931, 14.446, 33.9341, 14.1498, 33.5163, 13.9646);
    path.close();

    // Scale from 40x40 SVG to actual size
    final scale = size.width / 40.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Wind Speed Dial Painter (Red circular dial)
class WindSpeedDialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(110.0, 110.0);
    final radius = 50.0;
    final strokeRadius = 45.0;

    // Drop shadow effects
    final shadowPaint1 = Paint()
      ..color = const Color.fromARGB(255, 31, 30, 30)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);

    canvas.drawCircle(
      Offset(center.dx - 1, center.dy + 1),
      radius + 10,
      shadowPaint1,
    );

    // final shadowPaint2 = Paint()
    //   ..color = Color.fromRGBO(51, 58, 68, 0.4) // rgba(51, 58, 68, 0.4)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0);

    // canvas.drawCircle(
    //   Offset(center.dx - 10, center.dy - 10),
    //   radius + 10,
    //   shadowPaint2,
    // );

    // Fill gradient
    final fillGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(121, 31, 29, 1.0), // #791F1D
        Color.fromRGBO(201, 57, 54, 1.0), // #C93936
      ],
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = fillGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, fillPaint);

    // Stroke gradient
    final strokeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(157, 55, 52, 1.0), // #9D3734
        Color.fromRGBO(85, 20, 18, 1.0), // #551412
      ],
    );

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..shader = strokeGradient.createShader(
        Rect.fromCircle(center: center, radius: strokeRadius),
      );

    canvas.drawCircle(center, strokeRadius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Refrigeration Icon Painter (Snowflake icon)
class RefrigerationIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final svgCenter = Offset(70.0, 70.0);
    final scale = size.width / 160.0;

    canvas.save();
    canvas.scale(scale);

    // Drop shadow
    final shadowPaint = Paint()
      ..color = Colors.black
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0);

    canvas.drawCircle(svgCenter, 30.0, shadowPaint);

    // Main circle
    final circlePaint = Paint()
      ..color = Color.fromRGBO(36, 36, 36, 1.0) // #242424
      ..style = PaintingStyle.fill;

    canvas.drawCircle(svgCenter, 30.0, circlePaint);

    // Snowflake icon paths (white)
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Vertical line
    canvas.drawRect(
      Rect.fromCenter(center: Offset(70.0, 70.0), width: 1.0, height: 18.0),
      iconPaint,
    );

    // Top chevron (V shape pointing up)
    final topChevron = Path();
    topChevron.moveTo(66.2929, 58.2929);
    topChevron.lineTo(70.0, 60.5858);
    topChevron.lineTo(73.7071, 58.2929);
    topChevron.lineTo(70.7071, 62.7071);
    topChevron.close();
    canvas.drawPath(topChevron, iconPaint);

    // Bottom chevron (V shape pointing down)
    final bottomChevron = Path();
    bottomChevron.moveTo(66.2929, 81.7071);
    bottomChevron.lineTo(70.0, 79.4142);
    bottomChevron.lineTo(73.7071, 81.7071);
    bottomChevron.lineTo(70.7071, 77.2929);
    bottomChevron.close();
    canvas.drawPath(bottomChevron, iconPaint);

    // Diagonal lines (simplified)
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Main diagonal lines
    canvas.drawLine(Offset(62.2094, 65.4998), Offset(77.7913, 74.5002), strokePaint);
    canvas.drawLine(Offset(77.7913, 65.4998), Offset(62.2094, 74.5002), strokePaint);

    // Decorative diagonal lines
    canvas.drawLine(Offset(61.7157, 60.9342), Offset(64.0407, 65.7409), strokePaint);
    canvas.drawLine(Offset(81.9909, 72.6409), Offset(78.9909, 77.8409), strokePaint);
    canvas.drawLine(Offset(58.009, 72.6409), Offset(61.009, 77.8409), strokePaint);
    canvas.drawLine(Offset(78.2839, 60.9342), Offset(75.959, 65.7409), strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Outer Circle Painter
class TemperatureDialOuterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Outer circle stroke
    final outerGradient = LinearGradient(
      end: Alignment.topCenter,
      begin: Alignment.center,
      colors: [
        Color.fromRGBO(32, 134, 236, 0.451), // #0095FF opacity 0
        Color.fromRGBO(0, 132, 255, 0.952), // #0085FF opacity 0.2
      ],
      stops: [0.649, 1.0],
    );

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = outerGradient.createShader(
        Rect.fromCircle(center: center, radius: 180.0),
      );

    canvas.drawCircle(center, 180.0, outerPaint);

    // Inner circle stroke
    final innerGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(0, 149, 255, 0.0), // #0095FF opacity 0
        Color.fromRGBO(0, 133, 255, 0.2), // #0085FF opacity 0.2
      ],
      stops: [0.649, 1.0],
    );

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = innerGradient.createShader(
        Rect.fromCircle(center: center, radius: 180.0),
      );

    canvas.drawCircle(center, 180.0, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Blur Effect 1 (black ellipse)
class TemperatureDialBlurPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(212.255, 212.255);
    final radiusX = 112.255;
    final radiusY = 112.255;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 40.0);

    canvas.drawOval(
      Rect.fromCenter(center: center, width: radiusX * 2, height: radiusY * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Blur Effect 2 (gray ellipse)
class TemperatureDialBlurPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(193.68, 196.606);
    final radiusX = 116.606;
    final radiusY = 116.606;

    final paint = Paint()
      ..color = Color.fromRGBO(116, 138, 158, 0.2) // #748A9E opacity 0.2
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 40.0);

    canvas.drawOval(
      Rect.fromCenter(center: center, width: radiusX * 2, height: radiusY * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Main Circle Painter
class TemperatureDialMainCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 115.304;

    // Fill gradient
    final fillGradient = LinearGradient(
      begin: Alignment.center,
      end: Alignment.center,
      colors: [
        Color.fromRGBO(35, 40, 47, 1.0), // #23282F
        Color.fromRGBO(17, 19, 23, 1.0), // #111317
      ],
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = fillGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, fillPaint);

    // Stroke gradient
    final strokeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(55, 66, 78, 1.0), // #37424E
        Color.fromRGBO(7, 10, 13, 1.0), // #070A0D
      ],
    );

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..shader = strokeGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Arc Painter (blue arc)
class TemperatureDialArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    
    // Arc path from SVG
    path.moveTo(82.2026, 211.184);
    path.cubicTo(81.2564, 210.957, 80.3103, 210.717, 79.3647, 210.464);
    path.cubicTo(22.2613, 195.163, -11.6265, 136.468, 3.67434, 79.3644);
    path.cubicTo(18.9724, 22.2714, 77.6489, -11.6145, 134.743, 3.66552);
    path.cubicTo(135.638, 3.78624, 136.536, 3.96541, 137.433, 4.20558);
    path.cubicTo(148.664, 7.21507, 155.355, 18.6639, 152.377, 29.7772);
    path.cubicTo(149.399, 40.8905, 137.881, 47.4599, 126.649, 44.4505);
    path.cubicTo(125.541, 44.1536, 124.478, 43.7747, 123.463, 43.3221);
    path.cubicTo(88.5529, 34.3365, 52.8421, 55.1338, 43.4908, 90.0332);
    path.cubicTo(34.2771, 124.42, 54.0701, 159.745, 87.8708, 170.029);
    path.cubicTo(89.5037, 170.074, 91.1582, 170.309, 92.8066, 170.751);
    path.cubicTo(104.038, 173.76, 110.729, 185.209, 107.751, 196.322);
    path.cubicTo(104.792, 207.365, 93.4011, 213.921, 82.2379, 211.052);
    path.close();

    // Conic gradient (simulated with linear gradient approximation)
    final gradient = SweepGradient(
      endAngle: 3.14159 * 2,
      startAngle: 0.0,
      colors: [
        Color.fromRGBO(0, 75, 144, 1.0), // rgba(0, 75, 144, 1)
        Color.fromRGBO(0, 148, 255, 1.0), // rgba(0, 148, 255, 1) at 185.625deg
        Color.fromRGBO(92, 186, 255, 1.0), // rgba(92, 186, 255, 1) at 121.875deg
        Color.fromRGBO(0, 75, 144, 1.0), // rgba(0, 75, 144, 1) at 360deg
      ],
      stops: [0.0, 0.338, 0.516, 1.0],
    );

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Crosshair Painter
class TemperatureDialCrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(149.673, 149.673);
    final paint = Paint()
      ..color = Color.fromRGBO(0, 148, 255, 1.0) // #0094FF
      ..style = PaintingStyle.fill;

    // Top vertical line
    canvas.drawRect(
      Rect.fromLTWH(center.dx - 0.5, 0, 1.0, 13.053),
      paint,
    );

    // Bottom vertical line
    canvas.drawRect(
      Rect.fromLTWH(center.dx - 0.5, size.height - 13.053, 1.0, 13.053),
      paint,
    );

    // Right horizontal line
    canvas.drawRect(
      Rect.fromLTWH(size.width - 13.053, center.dy - 0.5, 13.053, 1.0),
      paint,
    );

    // Left horizontal line
    canvas.drawRect(
      Rect.fromLTWH(0, center.dy - 0.5, 13.053, 1.0),
      paint,
    );

    // Diagonal lines - rotated 90 degrees to be perpendicular to circle
    final strokePaint = Paint()
      ..color = Color.fromRGBO(0, 148, 255, 1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Top-right (rotated 90 degrees from diagonal to be perpendicular)
    final topRightPath = Path();
    topRightPath.moveTo(255.508 - 5.0, 53.068 + 5.0);
    topRightPath.lineTo(255.508 + 5.0, 53.068 - 5.0);
    canvas.drawPath(topRightPath, strokePaint);

    // Bottom-left (rotated 90 degrees from diagonal to be perpendicular)
    final bottomLeftPath = Path();
    bottomLeftPath.moveTo(53.068 - 5.0, 255.508 + 5.0);
    bottomLeftPath.lineTo(53.068 + 5.0, 255.508 - 5.0);
    canvas.drawPath(bottomLeftPath, strokePaint);

    // Top-left (rotated 90 degrees from diagonal to be perpendicular)
    final topLeftPath = Path();
    topLeftPath.moveTo(45.6847 - 5.0, 53.068 - 5.0);
    topLeftPath.lineTo(45.6847 + 5.0, 53.068 + 5.0);
    canvas.drawPath(topLeftPath, strokePaint);

    // Bottom-right
    final bottomRightPath = Path();
    bottomRightPath.moveTo(246.278 - 5.0, 255.508 - 5.0);
    bottomRightPath.lineTo(246.278 + 5.0, 255.508 + 5.0);
    canvas.drawPath(bottomRightPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Temperature Dial Center Dot Painter
class TemperatureDialCenterDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Outer circle with gradient fill
    final fillGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(49, 57, 63, 1.0), // #31393F
        Color.fromRGBO(26, 29, 31, 1.0), // #1A1D1F
      ],
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = fillGradient.createShader(
        Rect.fromCircle(center: center, radius: 15.07),
      );

    canvas.drawCircle(center, 15.07, fillPaint);

    // Outer stroke
    final strokeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(69, 78, 85, 1.0), // #454E55
        Color.fromRGBO(12, 14, 15, 1.0), // #0C0E0F
      ],
    );

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = strokeGradient.createShader(
        Rect.fromCircle(center: center, radius: 15.07),
      );

    canvas.drawCircle(center, 15.07, strokePaint);

    // Center dot
    final dotPaint = Paint()
      ..color = Color.fromRGBO(17, 151, 247, 1.0) // #1197F7
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 1.773, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

