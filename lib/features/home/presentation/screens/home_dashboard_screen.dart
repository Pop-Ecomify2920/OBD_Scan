import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/error_boundary.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import '../../../../core/routes/route_names.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home dashboard
        break;
      case 1:
        // Location/Map screen
        break;
      case 2:
        // Car/Vehicle screen
        break;
      case 3:
        context.go(RouteNames.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                      height:
                          1200.0, // Explicit height to ensure scrollable content
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Header
                          _buildHeader(context, screenWidth),
                          // Aura image
                          _buildAuraImage(screenWidth),
                          // Fuel Range card
                          _buildFuelRangeCard(screenWidth),
                          // Oil Range card
                          _buildOilRangeCard(screenWidth),
                          // Remote Control section
                          _buildRemoteControlSection(screenWidth),
                          // Tyre Pressure section
                          _buildTyrePressureSection(screenWidth),
                          // Location card
                          _buildLocationCard(screenWidth),
                          // Climate card
                          _buildClimateCard(screenWidth),
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
      left: 20.0,
      top: 18.0,
      right: 20.0,
      child: ErrorBoundary(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu icon
            GestureDetector(
              onTap: () {
                // Handle menu tap
              },
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: CustomPaint(
                  painter: MenuIconPainter(),
                ),
              ),
            ),
            // Title and subtitle
            Column(
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
                ),
                SizedBox(height: 4.0),
                Text(
                  "Parked",
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(214, 214, 214, 1.0), // #d6d6d6
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            // Notification icon
            GestureDetector(
              onTap: () {
                // Handle notification tap
              },
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
    );
  }

  Widget _buildAuraImage(double screenWidth) {
    return Positioned(
      left: (screenWidth - 263.0) / 2,
      top: 147.5,
      child: ErrorBoundary(
        child: Stack(
          children: [
            // Blur effect ellipse
            Positioned(
              left: 91.69 - (screenWidth - 263.0) / 2,
              top: 92.06, // 239.56 - 147.5
              child: CustomPaint(
                size: Size(257.0, 19.0),
                painter: AuraBlurPainter(),
              ),
            ),
            // Aura image
            Image.asset(
              'assets/images/aura2-3.png',
              width: 263.0,
              height: 99.35,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 263.0,
                  height: 99.35,
                  color: Colors.grey.withOpacity(0.3),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelRangeCard(double screenWidth) {
    return Positioned(
      left: 20.0,
      top: 286.0,
      child: ErrorBoundary(
        child: Container(
          width: 183.0,
          height: 224.0, // h-56 = 224px
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 35, 35, 1), // #242424
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "FUEL RANGE",
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 5.0),
              // Value and unit
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "125",
                    style: GoogleFonts.inter(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    "KM",
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Color.fromRGBO(120, 120, 120, 1.0), // #787878
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 32.0),
              // Circular progress indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  CustomPaint(
                    size: Size(80.0, 80.0),
                    painter: FuelRangeBackgroundPainter(),
                  ),
                  // Progress arc
                  Positioned(
                    left: 0.5,
                    top: 19.0,
                    child: CustomPaint(
                      size: Size(43.0, 43.0),
                      painter: FuelRangeProgressPainter(),
                    ),
                  ),
                  // Percentage text
                  Positioned(
                    top: 49.0,
                    child: Text(
                      "24%",
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOilRangeCard(double screenWidth) {
    return Positioned(
      left: screenWidth - 203.0, // 227px from left = screenWidth - 183 - 20
      top: 286.0,
      child: ErrorBoundary(
        child: Container(
          width: 183.0,
          height: 224.0,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1.0), // #242424
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "OIL RANGE",
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 5.0),
              // Value and unit
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "1680",
                    style: GoogleFonts.inter(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    "KM",
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Color.fromRGBO(120, 120, 120, 1.0), // #787878
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              // Circular progress indicator
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  CustomPaint(
                    size: Size(80.0, 80.0),
                    painter: OilRangeBackgroundPainter(),
                  ),
                  // Progress arc
                  CustomPaint(
                    size: Size(80.0, 80.0),
                    painter: OilRangeProgressPainter(),
                  ),
                  // Percentage text
                  Positioned(
                    top: 22.0,
                    child: Text(
                      "80%",
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoteControlSection(double screenWidth) {
    return Positioned(
      left: 20.0,
      top: 530.0,
      child: ErrorBoundary(
        child: Container(
          width: screenWidth - 40.0,
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 40.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1.0), // #242424
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    "REMOTE CONTROL",
                    style: GoogleFonts.inter(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRemoteControlButton(Icons.lock, () {}),
                      _buildRemoteControlButton(Icons.ac_unit, () {}),
                      _buildRemoteControlButton(Icons.lock_outline, () {}),
                      _buildRemoteControlButton(Icons.volume_up, () {}),
                    ],
                  ),
                ],
              ),
              // Settings icon
              Positioned(
                right: 16.0,
                top: -3.9,
                child: GestureDetector(
                  onTap: () {
                    context.go(RouteNames.settings);
                  },
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CustomPaint(
                      painter: SettingsIconPainter(),
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

  Widget _buildRemoteControlButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: Color.fromRGBO(186, 186, 186, 1.0), // #BABABA
          size: 24.0,
        ),
      ),
    );
  }

  Widget _buildTyrePressureSection(double screenWidth) {
    return Positioned(
      left: 20.0,
      top: 988.0,
      child: ErrorBoundary(
        child: Container(
          width: screenWidth - 40.0,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1.0), // #242424
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text(
                "TYRE PRESSURE",
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 70.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "32",
                        style: GoogleFonts.inter(
                          fontSize: 32.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        "PSI",
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                          color: Color.fromRGBO(88, 88, 88, 1.0), // #585858
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 70.0),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 32.0),
                  Text(
                    "TYRE 3 - OPTIMUM",
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: Color.fromRGBO(19, 166, 222, 1.0), // #13a6de
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard(double screenWidth) {
    return Positioned(
      left: 20.0,
      top: 738.25,
      child: ErrorBoundary(
        child: Container(
          width: 183.0,
          height: 224.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.14),
                Colors.white.withOpacity(0.0),
                Color.fromRGBO(5, 202, 173, 0.0),
                Color.fromRGBO(5, 202, 173, 0.2),
              ],
              stops: [0.0, 0.39, 0.76, 0.98],
            ),
          ),
          child: Stack(
            children: [
              // Complex SVG paths would go here - simplified for now
              Positioned(
                bottom: 0,
                left: 75.0,
                child: Text(
                  "LOCATION",
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
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

  Widget _buildClimateCard(double screenWidth) {
    return Positioned(
      left: screenWidth - 203.0,
      top: 739.0,
      child: ErrorBoundary(
        child: Container(
          width: 183.0,
          height: 224.0,
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 40.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1.0), // #242424
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "CLIMATE",
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(234, 234, 234, 1.0), // #eaeaea
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                "19°",
                style: GoogleFonts.inter(
                  fontSize: 32.0,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRemoteControlButton(Icons.remove, () {}),
                  SizedBox(width: 11.0),
                  _buildRemoteControlButton(Icons.add, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painters
class MenuIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw three horizontal lines
    canvas.drawLine(Offset(4, 16), Offset(28, 16), paint);
    canvas.drawLine(Offset(4, 8), Offset(22, 8), paint);
    canvas.drawLine(Offset(4, 24), Offset(17, 24), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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
    path.moveTo(18.1337, 26.6667);
    path.lineTo(13.867, 26.6667);
    path.moveTo(22.667, 13.3333);
    path.arcToPoint(Offset(9.33366, 13.3333), radius: Radius.circular(3.33333));
    path.lineTo(9.33366, 16.672);
    path.arcToPoint(Offset(8.70433, 17.6907), radius: Radius.circular(0.5));
    path.lineTo(8.03366, 18.0253);
    path.arcToPoint(Offset(6.66699, 20.2373), radius: Radius.circular(1.5));
    path.arcToPoint(Offset(9.13899, 22.7093), radius: Radius.circular(1.5));
    path.lineTo(22.8617, 22.7093);
    path.arcToPoint(Offset(25.3337, 20.2373), radius: Radius.circular(1.5));
    path.arcToPoint(Offset(24.8043, 18.4453), radius: Radius.circular(1.5));
    path.lineTo(23.967, 18.0267);
    path.lineTo(23.2963, 17.692);
    path.arcToPoint(Offset(22.667, 16.672), radius: Radius.circular(0.5));
    path.lineTo(22.667, 13.3333);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SettingsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(186, 186, 186, 1.0) // #BABABA
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Draw three dots
    canvas.drawCircle(Offset(16.0, 8.0), 1.5, paint);
    canvas.drawCircle(Offset(16.0, 16.0), 1.5, paint);
    canvas.drawCircle(Offset(16.0, 24.0), 1.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuraBlurPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(4, 4, 4, 1.0) // #040404
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2.0);

    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FuelRangeBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round;

    // Draw circle centered in the 80x80 size
    final center = Offset(size.width / 2, size.height / 1.3);
    final radius = size.width / 2 - 3; // r="37" in 80px circle = 40 - 3

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FuelRangeProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // The SVG path is: M3 40C3 19.5655 19.5655 3 40 3
    // This is a cubic bezier curve from (3, 40) to (40, 3) in a 43x43 viewBox
    // This creates an arc from bottom-left to top-right

    final gradient = LinearGradient(
      begin: Alignment(0.378, 0.336), // x1=16.2717/43, y1=14.462/43
      end: Alignment(-0.075, 0.865), // x2=-3.23369/43, y2=37.1848/43
      colors: [
        Color.fromRGBO(24, 137, 216, 1.0), // #1889D8
        Color.fromRGBO(1, 255, 240, 1.0), // #01FFF0
      ],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Convert SVG coordinates to Flutter path
    // SVG: M3 40C3 19.5655 19.5655 3 40 3
    // In 43x43 viewBox, this creates an arc from bottom-left to top-right
    final path = Path();
    path.moveTo(2.5, 40.0);
    path.cubicTo(
      3.7, 19.6655, // Control point 1
      19.6655, 3.7, // Control point 2
      42, 5.5, // End point
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OilRangeBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round;

    // Draw circle centered in the 80x80 size
    final center = Offset(size.width / 2, size.height / 2.1);
    final radius = size.width / 2 - 3; // r="37" in 80px circle = 40 - 3

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OilRangeProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // The SVG path is: M77 40C77 60.4345 60.4345 77 40 77C19.5655 77 3 60.4345 3 40C3 19.5655 19.5655 3 40 3
    // This is an arc from (77, 40) going counter-clockwise to (3, 40), then to (40, 3)
    // For 80% progress, we need approximately 288 degrees (80% of 360)

    final center = Offset(size.width / 2, size.height / 2.1);
    final radius = size.width / 2 - 3;

    final gradient = LinearGradient(
      begin: Alignment(0.2375, 0.16875), // x1=19/80, y1=13.5/80
      end: Alignment(0.9608, 0.7279), // x2=76.8618/80, y2=58.2332/80
      colors: [
        Color.fromRGBO(189, 0, 255, 1.0), // #BD00FF
        Color.fromRGBO(255, 1, 184, 1.0), // #FF01B8
      ],
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    // Draw arc for 80% (approximately 288 degrees = 5.026 radians)
    // Starting from bottom (-90 degrees) and sweeping 288 degrees counter-clockwise
    final path = Path();
    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // Start at bottom (-90 degrees)
      5.026, // 80% of 2π ≈ 5.026 radians (288 degrees)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
