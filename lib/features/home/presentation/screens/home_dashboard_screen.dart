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

    // Navigate based on index
    switch (index) {
      case 0:
        // Navigate to home dashboard
        context.go(RouteNames.home);
        break;
      case 1:
        // Location/Map screen - navigate if exists
        context.go(RouteNames.safety);
        break;
      case 2:
        // Car/Vehicle screen - navigate if exists
        context.go(RouteNames.homeDashboard);
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
            bottom: false,
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
      left: (screenWidth - 263.0) / 2.3,
      top: 123,
      child: ErrorBoundary(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Blur effect ellipse
            Positioned(
              left: 91.69 - (screenWidth - 203.0) / 2,
              top: 101.06,
              child: CustomPaint(
                size: Size(287.0, 20.0),
                painter: AuraBlurPainter(),
              ),
            ),
            // Aura image - using contain to show full image including shadow
            SizedBox(
              width: 283.0,
              height:
                  120.0, // Increased height to show full image including shadow
              child: Image.asset(
                'assets/images/aura2-3.png',
                width: 263.0,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 263.0,
                    height: 120.0,
                    color: const Color.fromARGB(255, 2, 2, 2).withOpacity(0.3),
                  );
                },
              ),
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
          width: 180.0,
          height: 224.0, // h-56 = 224px
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 22, 22, 0.685), // #242424
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
                    top: 50.0,
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
      left: screenWidth - 202.0, // 227px from left = screenWidth - 183 - 20
      top: 286.0,
      child: ErrorBoundary(
        child: Container(
          width: 180.0,
          height: 224.0,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 22, 22, 0.685), // #242424
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
                    top: 27.0,
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
            color: Color.fromRGBO(22, 22, 22, 0.685), // #242424
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
        width: 61.0,
        height: 61.0,
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
            color: Color.fromRGBO(22, 22, 22, 0.685), // #242424
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
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
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
                  SizedBox(width: 15.0),
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
          width: 180.0,
          height: 224.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.3), // 182.54deg
              end: Alignment(0.0, 1.0),
              colors: [
                Color.fromRGBO(255, 255, 255, 0.14), // -8.34%
                Color.fromRGBO(255, 255, 255, 0), // 39%
                Color.fromRGBO(5, 202, 173, 0), // 76.21%
                Color.fromRGBO(5, 202, 173, 0.2), // 98.1%
              ],
              stops: [0.0, 0.39, 0.76, 0.98],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Backdrop blur effect (simulated with opacity)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 180.0,
                  height: 224.0,
                  // color: Colors.white.withOpacity(0.2),
                ),
              ),
              // Location map paths - clipped to card boundaries
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomPaint(
                  size: Size(183.0, 224.0),
                  painter: LocationMapPainter(),
                ),
              ),
              // LOCATION text
              Positioned(
                bottom: 180.0,
                left: 0,
                right: 0,
                child: Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClimateCard(double screenWidth) {
    return Positioned(
      left: screenWidth - 202.0,
      top: 739.0,
      child: ErrorBoundary(
        child: Container(
          width: 180.0,
          height: 224.0,
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 40.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(22, 22, 22, 0.685), // #242424
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 70, 66, 66).withOpacity(0.25),
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
              // SizedBox(height: 32.0),
              Text(
                "19°",
                style: GoogleFonts.inter(
                  fontSize: 32.0,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 22.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRemoteControlButton(Icons.remove, () {}),
                  SizedBox(width: 8.0),
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

class LocationMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient 0: paint0_linear_344_464
    // x1="83.2636" y1="137.989" x2="-95.8422" y2="74.5383"
    final gradient0 = LinearGradient(
      begin: Alignment(0.455, 0.616), // 83.2636/183, 137.989/224
      end: Alignment(-0.524, 0.333), // -95.8422/183, 74.5383/224
      colors: [
        Color.fromRGBO(5, 202, 172, 0.247), // #05CAAD
        Color.fromRGBO(5, 202, 172, 0.582), // #05CAAD stop-opacity="0"
      ],
    );

    final paint0 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.13056
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Color.fromRGBO(5, 202, 172, 0.527) // stroke-opacity="0.3"
      ..shader = gradient0.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Gradient 1: paint1_linear_344_464
    // x1="71.6174" y1="123.78" x2="-74.4229" y2="11.1921"
    final gradient1 = LinearGradient(
      begin: Alignment(0.391, 0.553), // 71.6174/183, 123.78/224
      end: Alignment(-0.407, 0.050), // -74.4229/183, 11.1921/224
      colors: [
        Color.fromRGBO(5, 202, 173, 1.0), // #05CAAD
        Color.fromRGBO(5, 202, 172, 0.336), // #05CAAD stop-opacity="0"
      ],
    );

    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25222
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Color.fromRGBO(5, 202, 172, 0.5) // stroke-opacity="0.3"
      ..shader = gradient1.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Gradient 2: paint2_linear_344_464
    // x1="133.125" y1="107.978" x2="76.3236" y2="92.4043"
    final gradient2 = LinearGradient(
      begin: Alignment(0.727, 0.482), // 133.125/183, 107.978/224
      end: Alignment(0.417, 0.413), // 76.3236/183, 92.4043/224
      colors: [
        Color.fromRGBO(5, 202, 172, 0.808), // #05CAAD stop-opacity="0"
        Color.fromRGBO(5, 202, 173, 1.0), // #05CAAD
      ],
    );

    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.13056
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Color.fromRGBO(5, 202, 172, 0.562) // stroke-opacity="0.5"
      ..shader = gradient2.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Paint for #05CAAD with opacity 0.1
    final paint3 = Paint()
      ..color =
          Color.fromRGBO(5, 202, 172, 0.274) // #05CAAD stroke-opacity="0.1"
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25222
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Paint for #05CAAD with opacity 0.2
    final paint4 = Paint()
      ..color =
          Color.fromRGBO(5, 202, 172, 0.103) // #05CAAD stroke-opacity="0.2"
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25222
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Paint for #00FFDA (bright teal)
    final paint5 = Paint()
      ..color = Color.fromRGBO(0, 255, 218, 1.0) // #00FFDA
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Main path (paint0_linear_344_464, stroke-opacity="0.3", stroke-width="3.13056")
    final path0 = Path();
    path0.moveTo(74.5948, 85.2249);
    path0.cubicTo(71.2062, 84.3636, 64.9734, 81.6035, 62.7514, 81.0292);
    path0.moveTo(62.7514, 81.0292);
    path0.cubicTo(61.4358, 87.6606, 59.5006, 96.1235, 55.8037, 105.262);
    path0.cubicTo(52.1069, 114.4, 51.4852, 116.413, 49.248, 119.146);
    path0.cubicTo(44.4714, 126.034, 43.9587, 126.454, 42.6805, 127.783);
    path0.moveTo(42.6805, 127.783);
    path0.cubicTo(42.1726, 128.556, 34.0547, 177.876, 34.0547, 177.876);
    path0.lineTo(28.1516, 215.806);
    path0.cubicTo(28.0562, 216.419, 27.9039, 217.022, 27.6966, 217.607);
    path0.lineTo(24.9324, 225.41);
    path0.moveTo(62.7514, 81.0292);
    path0.lineTo(40.8482, 76.8447);
    path0.moveTo(40.8482, 76.8447);
    path0.cubicTo(37.8701, 78.6498, 22.6336, 84.6921, 22.6336, 84.6921);
    path0.moveTo(40.8482, 76.8447);
    path0.lineTo(13.6436, 15.0116);
    path0.moveTo(22.6336, 84.6921);
    path0.lineTo(31.4124, 106.391);
    path0.moveTo(22.6336, 84.6921);
    path0.lineTo(9.518, 90.0286);
    path0.moveTo(30.7956, 105.221);
    path0.lineTo(40.8482, 76.8447);
    path0.moveTo(30.7956, 105.221);
    path0.lineTo(31.4124, 106.391);
    path0.moveTo(9.58308, 173.02);
    path0.lineTo(11.5704, 178.127);
    path0.cubicTo(12.5678, 180.69, 12.4655, 183.551, 11.2874, 186.036);
    path0.lineTo(8.58244, 191.743);
    path0.cubicTo(7.35514, 194.333, 5.07607, 196.271, 2.32337, 197.067);
    path0.lineTo(-8.44034, 200.178);
    path0.cubicTo(-13.3431, 201.596, -18.5265, 199.094, -20.4667, 194.374);
    path0.lineTo(-29.6171, 172.112);
    path0.lineTo(-40.5446, 145.528);
    path0.moveTo(9.58308, 173.02);
    path0.lineTo(11.9837, 166.244);
    path0.lineTo(21.436, 139.562);
    path0.cubicTo(22.0753, 137.384, 23.6848, 125.474, 25.0192, 121.526);
    path0.cubicTo(26.3536, 117.578, 26.6072, 115.391, 30.7956, 105.221);
    path0.moveTo(9.58308, 173.02);
    path0.lineTo(-7.6417, 132.121);
    path0.moveTo(-20.2653, 102.147);
    path0.lineTo(-52.6025, 116.193);
    path0.moveTo(-20.2653, 102.147);
    path0.lineTo(-7.6417, 132.121);
    path0.moveTo(-20.2653, 102.147);
    path0.lineTo(-32.2024, 73.1308);
    path0.moveTo(-20.2653, 102.147);
    path0.lineTo(1.18413, 93.4194);
    path0.moveTo(-52.6025, 116.193);
    path0.lineTo(-40.5446, 145.528);
    path0.moveTo(-52.6025, 116.193);
    path0.lineTo(-98.364, 136.446);
    path0.moveTo(-52.6025, 116.193);
    path0.lineTo(-64.7301, 86.3944);
    path0.moveTo(-7.6417, 132.121);
    path0.lineTo(-40.5446, 145.528);
    path0.moveTo(-40.5446, 145.528);
    path0.lineTo(-65.5301, 157.306);
    path0.cubicTo(-69.1356, 159.005, -73.4061, 158.401, -76.3989, 155.769);
    path0.lineTo(-98.364, 136.446);
    path0.moveTo(-98.364, 136.446);
    path0.lineTo(-104.007, 111.115);
    path0.cubicTo(-105.073, 106.327, -102.509, 101.472, -97.9526, 99.6535);
    path0.lineTo(-64.7301, 86.3944);
    path0.moveTo(-64.7301, 86.3944);
    path0.lineTo(-32.2024, 73.1308);
    path0.moveTo(-64.7301, 86.3944);
    path0.lineTo(-79.1606, 56.4953);
    path0.moveTo(-32.2024, 73.1308);
    path0.lineTo(-11.4254, 63.3312);
    path0.moveTo(-32.2024, 73.1308);
    path0.lineTo(-48.2892, 45.2666);
    path0.moveTo(-11.4254, 63.3312);
    path0.lineTo(1.18413, 93.4194);
    path0.moveTo(-11.4254, 63.3312);
    path0.lineTo(-5.63668, 60.8535);
    path0.moveTo(1.18413, 93.4194);
    path0.lineTo(9.518, 90.0286);
    path0.moveTo(9.518, 90.0286);
    path0.lineTo(-5.63668, 60.8535);
    path0.moveTo(-5.63668, 60.8535);
    path0.lineTo(-19.4783, 32.593);
    path0.moveTo(-19.4783, 32.593);
    path0.lineTo(-48.2892, 45.2666);
    path0.moveTo(-19.4783, 32.593);
    path0.lineTo(13.6436, 15.0116);
    path0.moveTo(-48.2892, 45.2666);
    path0.lineTo(-79.1606, 56.4953);
    path0.moveTo(-79.1606, 56.4953);
    path0.lineTo(-86.8711, 60.4371);
    path0.moveTo(76.0088, 84.5342);
    path0.cubicTo(70.7495, 100.1, 67.9657, 107.916, 63.5109, 119.87);
    path0.cubicTo(63.242, 120.592, 63.0565, 121.343, 62.9594, 122.106);
    path0.lineTo(54.723, 186.866);
    path0.lineTo(52.1924, 220.695);
    path0.cubicTo(51.903, 224.563, 49.4025, 227.915, 45.7769, 229.295);
    path0.lineTo(32.257, 234.44);
    path0.moveTo(32.257, 234.44);
    path0.lineTo(24.9324, 225.41);
    path0.moveTo(32.257, 234.44);
    path0.lineTo(31.0623, 234.4);
    path0.cubicTo(26.5045, 234.247, 23.4096, 229.708, 24.9324, 225.41);
    path0.moveTo(47.3161, 61.4992);
    path0.lineTo(77.3452, 13.2188);
    path0.cubicTo(79.1459, 10.3237, 79.3475, 6.71054, 77.88, 3.63305);
    path0.lineTo(77.0703, 1.93516);
    path0.cubicTo(74.8376, -2.74693, 69.3955, -4.94451, 64.5376, -3.12565);
    path0.lineTo(44.0051, 4.56208);
    path0.moveTo(33.2203, 8.60008);
    path0.lineTo(44.0051, 4.56208);
    path0.moveTo(13.6436, 15.0116);
    path0.lineTo(7.81361, -0.930761);
    path0.cubicTo(6.06153, -5.7219, 8.19681, -11.0638, 12.7687, -13.3272);
    path0.lineTo(22.7656, -18.2762);
    path0.cubicTo(27.912, -20.8239, 34.142, -18.5238, 36.3981, -13.243);
    path0.lineTo(44.0051, 4.56208);

    canvas.drawPath(path0, paint0);

    // Secondary path (paint1_linear_344_464, stroke-opacity="0.3", stroke-width="1.25222")
    final path1 = Path();
    path1.moveTo(68.9772, 78.7199);
    path1.lineTo(61.6441, 96.8176);
    path1.moveTo(55.7366, 100.44);
    path1.lineTo(47.8604, 99.0402);
    path1.moveTo(43.1933, 120.751);
    path1.lineTo(47.8604, 99.0402);
    path1.moveTo(38.6789, 140.243);
    path1.cubicTo(43.5799, 140.624, 46.867, 145.446, 45.4312, 150.148);
    path1.lineTo(43.3357, 157.009);
    path1.cubicTo(42.2655, 160.513, 39.2978, 163.105, 35.6815, 163.695);
    path1.cubicTo(29.0552, 164.775, 23.3878, 158.908, 24.6961, 152.323);
    path1.lineTo(30.9158, 121.02);
    path1.moveTo(16.1781, 83.5705);
    path1.lineTo(18.4057, 90.1592);
    path1.cubicTo(19.0153, 91.9624, 20.4945, 93.3357, 22.3379, 93.8101);
    path1.cubicTo(25.606, 94.6512, 27.4062, 98.1575, 26.185, 101.303);
    path1.lineTo(11.6966, 138.626);
    path1.moveTo(41.1589, 106.723);
    path1.lineTo(41.9712, 105.792);
    path1.moveTo(47.8604, 99.0402);
    path1.lineTo(41.9712, 105.792);
    path1.moveTo(53.413, 75.6762);
    path1.lineTo(49.3799, 88.3911);
    path1.cubicTo(48.8999, 89.9042, 48.0667, 91.2812, 46.9491, 92.4084);
    path1.lineTo(41.4497, 97.955);
    path1.cubicTo(39.2314, 100.192, 39.476, 103.868, 41.9712, 105.792);
    path1.moveTo(28.9903, 75.5372);
    path1.lineTo(20.4458, 58.8343);
    path1.cubicTo(19.0133, 56.034, 15.5227, 55.0117, 12.8058, 56.5968);
    path1.cubicTo(10.4107, 57.9941, 9.43691, 60.9604, 10.5377, 63.5054);
    path1.lineTo(17.7047, 80.0751);
    path1.moveTo(12.5149, 80.7463);
    path1.lineTo(7.07659, 67.5984);
    path1.moveTo(7.82062, 127.744);
    path1.lineTo(-4.27403, 132.827);
    path1.moveTo(7.82062, 127.744);
    path1.lineTo(15.5725, 149.507);
    path1.moveTo(7.82062, 127.744);
    path1.lineTo(0.601861, 109.33);
    path1.moveTo(17.9586, 88.8367);
    path1.lineTo(-6.71916, 98.6245);
    path1.moveTo(9.29795, 100.071);
    path1.lineTo(-15.3798, 109.858);
    path1.moveTo(45.6487, 75.1415);
    path1.lineTo(43.5722, 82.8853);
    path1.moveTo(8.56466, 187.89);
    path1.lineTo(3.70623, 177.526);
    path1.moveTo(-20.4806, 150.313);
    path1.lineTo(-19.6492, 149.977);
    path1.cubicTo(-14.7245, 147.989, -9.10423, 150.197, -6.85003, 155.006);
    path1.lineTo(-1.15219, 167.161);
    path1.moveTo(-20.4806, 150.313);
    path1.lineTo(-10.2399, 173.393);
    path1.moveTo(-20.4806, 150.313);
    path1.cubicTo(-29.2314, 140.452, -31.6748, 148.127, -29.99, 146.486);
    path1.moveTo(-20.4806, 150.313);
    path1.lineTo(-58.8872, 167.925);
    path1.moveTo(-10.2399, 173.393);
    path1.lineTo(-1.15219, 167.161);
    path1.moveTo(-10.2399, 173.393);
    path1.lineTo(-17.8111, 176.901);
    path1.moveTo(3.70623, 177.526);
    path1.lineTo(-3.92793, 181.948);
    path1.cubicTo(-9.11782, 184.955, -15.7639, 182.539, -17.8111, 176.901);
    path1.moveTo(-17.8111, 176.901);
    path1.lineTo(-20.5198, 170.494);
    path1.cubicTo(-22.3006, 166.281, -20.5512, 161.407, -16.4981, 159.289);
    path1.moveTo(-34.6835, 105.1);
    path1.cubicTo(-34.6017, 105.733, -32.9715, 109.906, -31.2285, 114.233);
    path1.cubicTo(-29.5089, 118.502, -31.3876, 123.387, -35.5474, 125.357);
    path1.lineTo(-37.3998, 126.234);
    path1.cubicTo(-40.7297, 127.811, -44.7062, 126.361, -46.2406, 123.012);
    path1.cubicTo(-47.7505, 119.716, -46.3243, 115.818, -43.0435, 114.275);
    path1.lineTo(-25.7541, 106.143);
    path1.moveTo(-2.59636, 76.105);
    path1.lineTo(-11.287, 80.3072);
    path1.moveTo(-11.287, 80.3072);
    path1.lineTo(-10.3044, 81.0648);
    path1.cubicTo(-7.90803, 82.9122, -8.39444, 86.6577, -11.1832, 87.8318);
    path1.cubicTo(-13.1596, 88.6639, -15.4388, 87.7666, -16.3176, 85.8105);
    path1.lineTo(-16.8261, 84.6787);
    path1.cubicTo(-18.3764, 81.2277, -14.2832, 77.9974, -11.287, 80.3072);
    path1.moveTo(-11.287, 80.3072);
    path1.lineTo(-15.0158, 68.4772);
    path1.moveTo(-27.3258, 99.0913);
    path1.lineTo(-35.7861, 81.2775);
    path1.moveTo(-35.7861, 81.2775);
    path1.lineTo(-36.2745, 81.5136);
    path1.cubicTo(-41.134, 83.8633, -40.7267, 90.9153, -35.6291, 92.69);
    path1.moveTo(-35.7861, 81.2775);
    path1.lineTo(-35.6291, 92.69);
    path1.moveTo(-35.7861, 81.2775);
    path1.lineTo(-29.6344, 77.8434);
    path1.moveTo(-35.7861, 81.2775);
    path1.cubicTo(-36.4169, 78.1647, -39.7263, 76.396, -42.6648, 77.6013);
    path1.lineTo(-47.428, 79.555);
    path1.cubicTo(-51.9133, 81.3947, -53.8405, 86.6964, -51.5835, 90.9869);
    path1.cubicTo(-49.6565, 94.65, -45.3064, 96.3089, -41.4296, 94.8591);
    path1.lineTo(-35.6291, 92.69);
    path1.moveTo(-35.6291, 92.69);
    path1.lineTo(-25.0797, 88.9615);
    path1.cubicTo(-24.2667, 88.6742, -23.4956, 88.2792, -22.7737, 87.8077);
    path1.cubicTo(-12.411, 81.04, -4.06333, 79.4181, -4.03667, 60.9776);
    path1.moveTo(19.5652, 28.1668);
    path1.cubicTo(15.815, 28.8725, 12.9894, 29.6616, 9.82044, 31.3384);
    path1.cubicTo(6.08136, 33.3167, 1.22409, 31.7231, 0.200524, 27.6186);
    path1.cubicTo(0.125778, 27.3188, 0.0245016, 27.0253, -0.0902443, 26.7385);
    path1.cubicTo(-1.01166, 24.4353, -0.907724, 22.8337, 7.61358, 20.4986);
    path1.cubicTo(12.4356, 19.1772, 17.3685, 22.0095, 19.0486, 26.7186);
    path1.lineTo(19.5652, 28.1668);
    path1.moveTo(19.5652, 28.1668);
    path1.cubicTo(-0.751946, 46.6426, -5.15921, 53.4387, -4.03667, 60.9776);
    path1.moveTo(-4.03667, 60.9776);
    path1.cubicTo(-8.62296, 59.8252, -12.3281, 58.0294, -15.1959, 56.1307);
    path1.cubicTo(-19.8132, 53.0738, -18.4367, 46.9702, -13.6255, 44.2286);
    path1.lineTo(-7.51007, 40.7437);
    path1.cubicTo(-6.83978, 40.3618, -6.5085, 39.5781, -6.7016, 38.8312);
    path1.cubicTo(-6.98144, 37.7487, -8.20814, 37.2221, -9.18566, 37.7647);
    path1.lineTo(-15.9117, 41.4985);
    path1.cubicTo(-19.4589, 43.4677, -23.9263, 42.3299, -26.0994, 38.9039);
    path1.lineTo(-28.5475, 35.0445);
    path1.cubicTo(-29.4747, 33.5826, -30.0066, 31.905, -30.0911, 30.176);
    path1.lineTo(-31.1003, 9.51133);
    path1.cubicTo(-31.3596, 4.20178, -27.4195, -0.382675, -22.1313, -0.924427);
    path1.lineTo(-7.0433, -2.47013);
    path1.moveTo(-7.0433, -2.47013);
    path1.lineTo(3.58064, -3.62442);
    path1.moveTo(-7.0433, -2.47013);
    path1.lineTo(-8.35199, -9.37207);
    path1.cubicTo(-8.7971, -11.7196, -7.51569, -14.0531, -5.29599, -14.9373);
    path1.cubicTo(-2.53698, -16.0364, 0.565377, -14.497, 1.35904, -11.6352);
    path1.lineTo(3.58064, -3.62442);
    path1.moveTo(3.58064, -3.62442);
    path1.cubicTo(3.58064, -3.62442, 10.3068, 0.782269, 6.3885, 7.88494);
    path1.cubicTo(3.67637, 12.8012, -1.16603, 13.4636, -3.89028, 13.4055);
    path1.cubicTo(-5.2215, 13.3771, -6.80613, 12.9417, -7.06936, 11.6364);
    path1.cubicTo(-7.49367, 9.53245, -4.94265, 5.68988, 3.58064, -3.62442);
    path1.moveTo(51.6458, 22.918);
    path1.lineTo(37.2232, 31.3573);
    path1.cubicTo(32.0603, 34.3783, 25.4179, 32.2212, 23.0151, 26.7433);
    path1.lineTo(5.73807, -12.6449);
    path1.cubicTo(5.34487, -13.5413, 5.57965, -14.5892, 6.31773, -15.2322);
    path1.cubicTo(7.46245, -16.2294, 9.24673, -15.8222, 9.84547, -14.4271);
    path1.lineTo(45.5167, 68.6879);
    path1.cubicTo(46.6752, 71.3873, 48.962, 73.4407, 51.7701, 74.3032);
    path1.lineTo(64.5411, 78.2257);
    path1.cubicTo(70.176, 79.9565, 76.0779, 76.4623, 77.2704, 70.6894);
    path1.lineTo(84.7496, 34.4816);
    path1.cubicTo(85.2078, 32.2638, 83.7106, 30.1158, 81.4713, 29.7781);
    path1.cubicTo(80.1289, 29.5757, 78.7766, 30.0771, 77.8906, 31.1057);
    path1.lineTo(42.2297, 72.5056);
    path1.moveTo(95.1293, 8.93885);
    path1.lineTo(77.4555, 10.0104);
    path1.cubicTo(76.4545, 10.0711, 75.4828, 10.3718, 74.6225, 10.8871);
    path1.lineTo(74.3325, 11.0609);
    path1.cubicTo(71.0631, 13.0193, 66.8206, 11.4584, 65.5999, 7.84809);
    path1.moveTo(65.5999, 7.84809);
    path1.lineTo(64.9061, 5.7959);
    path1.cubicTo(64.4063, 4.3176, 64.9711, 2.68848, 66.2786, 1.83674);
    path1.lineTo(67.2707, 1.19052);
    path1.cubicTo(68.4703, 0.409121, 70.0833, 0.85821, 70.7065, 2.14707);
    path1.cubicTo(71.2338, 3.23759, 70.8563, 4.5502, 69.8302, 5.19397);
    path1.lineTo(65.5999, 7.84809);
    path1.moveTo(55.9063, -5.3357);
    path1.cubicTo(55.9063, -5.3357, 56.3442, -10.4492, 51.9484, -13.8381);
    path1.cubicTo(49.8553, -15.4518, 46.5208, -16.2569, 43.6017, -16.6575);
    path1.cubicTo(39.975, -17.1553, 36.5558, -19.03, 34.7465, -22.2124);
    path1.lineTo(34.1285, -23.2996);
    path1.cubicTo(33.107, -25.0962, 32.3652, -27.4148, 33.7294, -28.9672);
    path1.cubicTo(34.5337, -29.8825, 35.8736, -30.3813, 38.0895, -29.1948);
    path1.cubicTo(43.0502, -26.5385, 49.1543, -3.14319, 49.1543, -3.14319);
    path1.moveTo(-56.8595, 61.1375);
    path1.lineTo(-57.5943, 53.1732);
    path1.moveTo(-50.5977, 7.56069);
    path1.lineTo(-68.7165, 12.7147);
    path1.cubicTo(-73.7033, 14.1332, -76.7789, 19.1279, -75.8009, 24.2195);
    path1.lineTo(-75.7081, 24.7024);
    path1.cubicTo(-74.5457, 30.7541, -68.2392, 34.3245, -62.452, 32.2073);
    path1.lineTo(-45.0373, 25.8363);
    path1.cubicTo(-42.6852, 24.9759, -41.3099, 22.5311, -41.7956, 20.0741);
    path1.cubicTo(-42.3697, 17.171, -45.2917, 15.3692, -48.1435, 16.1601);
    path1.lineTo(-52.9037, 17.4802);
    path1.cubicTo(-57.4101, 18.73, -60.3756, 23.0265, -59.946, 27.6832);
    path1.lineTo(-57.5943, 53.1732);
    path1.moveTo(-50.5977, 7.56069);
    path1.lineTo(-49.0575, 25.1519);
    path1.cubicTo(-48.6777, 29.4907, -44.2176, 32.2321, -40.1749, 30.6118);
    path1.cubicTo(-37.3477, 29.4787, -35.6883, 26.5326, -36.1847, 23.5276);
    path1.lineTo(-37.526, 15.4078);
    path1.cubicTo(-38.512, 9.43847, -44.5316, 5.70521, -50.3172, 7.47489);
    path1.lineTo(-50.5977, 7.56069);
    path1.moveTo(-51.3382, 49.4303);
    path1.lineTo(-49.2325, 54.9331);
    path1.cubicTo(-47.806, 58.6606, -49.545, 62.8527, -53.191, 64.4761);
    path1.cubicTo(-57.8695, 66.5592, -63.2147, 63.4504, -63.7175, 58.3539);
    path1.lineTo(-64.1096, 54.3801);
    path1.moveTo(-64.1096, 54.3801);
    path1.lineTo(-57.5943, 53.1732);
    path1.moveTo(-64.1096, 54.3801);
    path1.cubicTo(-68.7644, 54.8547, -72.4204, 58.5787, -72.8093, 63.2415);
    path1.lineTo(-74.3656, 81.9053);
    path1.moveTo(-74.3656, 81.9053);
    path1.lineTo(-75.1091, 90.8218);
    path1.cubicTo(-75.3983, 94.2898, -77.7276, 97.2512, -81.0299, 98.3493);
    path1.cubicTo(-86.4654, 100.157, -92.133, 96.3054, -92.4538, 90.5862);
    path1.lineTo(-92.7599, 85.1294);
    path1.cubicTo(-92.9951, 80.9364, -90.2483, 77.1566, -86.1876, 76.0854);
    path1.lineTo(-81.7775, 74.922);
    path1.cubicTo(-77.4838, 73.7893, -73.4904, 77.5518, -74.3656, 81.9053);
    path1.moveTo(-74.3656, 81.9053);
    path1.lineTo(-87.547, 82.2561);
    path1.lineTo(-94.0047, 82.708);
    path1.cubicTo(-100.265, 83.1462, -104.579, 89.1754, -102.974, 95.2422);
    path1.lineTo(-95.5967, 123.115);
    path1.cubicTo(-94.783, 126.19, -91.3675, 127.759, -88.5042, 126.375);
    path1.cubicTo(-85.5992, 124.97, -82.1393, 126.608, -81.3839, 129.745);
    path1.lineTo(-79.0536, 139.421);
    path1.moveTo(-74.4833, 120.361);
    path1.lineTo(-70.5297, 132.055);
    path1.cubicTo(-69.777, 134.282, -67.3047, 135.414, -65.1277, 134.529);
    path1.cubicTo(-62.9848, 133.658, -60.5473, 134.741, -59.7566, 136.915);
    path1.lineTo(-56.0866, 147.004);

    canvas.drawPath(path1, paint1);

    // Accent path (paint2_linear_344_464, stroke-opacity="0.5", stroke-width="3.13056")
    final path2 = Path();
    path2.moveTo(97.643, 46.2913);
    path2.lineTo(100.562, 37.8191);
    path2.lineTo(129.648, -25.9601);
    path2.cubicTo(132.371, -31.9311, 140.01, -33.705, 145.086, -29.5448);
    path2.lineTo(160.775, -16.6854);
    path2.cubicTo(163.985, -14.0545, 165.236, -9.71426, 163.919, -5.7784);
    path2.lineTo(144.545, 52.1266);
    path2.cubicTo(142.77, 57.4308, 136.99, 60.2481, 131.718, 58.3783);
    path2.lineTo(97.643, 46.2913);
    path2.moveTo(97.643, 46.2913);
    path2.lineTo(80.0276, 97.4167);
    path2.lineTo(79.2224, 99.7538);
    path2.moveTo(69.861, 126.923);
    path2.lineTo(55.6206, 168.253);
    path2.cubicTo(55.3182, 169.131, 55.1395, 170.047, 55.0896, 170.974);
    path2.lineTo(54.3511, 184.701);
    path2.moveTo(69.861, 126.923);
    path2.lineTo(92.841, 133.224);
    path2.cubicTo(94.4679, 133.67, 96.1811, 133.697, 97.8214, 133.303);
    path2.lineTo(114.268, 129.352);
    path2.cubicTo(117.22, 128.642, 119.691, 126.629, 120.982, 123.881);
    path2.lineTo(122.737, 120.145);
    path2.cubicTo(125.719, 113.798, 121.413, 106.433, 114.42, 105.919);
    path2.lineTo(110.773, 105.651);
    path2.cubicTo(110.127, 105.604, 109.487, 105.494, 108.862, 105.322);
    path2.lineTo(96.7163, 101.992);
    path2.lineTo(79.2224, 99.7538);
    path2.moveTo(69.861, 126.923);
    path2.lineTo(79.2224, 99.7538);
    path2.moveTo(54.3511, 184.701);
    path2.lineTo(52.4617, 219.819);
    path2.cubicTo(52.1233, 226.109, 57.6146, 231.142, 63.8515, 230.257);
    path2.lineTo(88.6955, 226.734);
    path2.cubicTo(93.2208, 226.092, 96.735, 222.464, 97.232, 217.92);
    path2.lineTo(100.712, 186.104);
    path2.cubicTo(101.484, 179.043, 94.857, 173.449, 88.0232, 175.385);
    path2.cubicTo(73.9386, 179.374, 57.6547, 183.94, 54.3511, 184.701);

    canvas.drawPath(path2, paint2);

    // Path with #05CAAD stroke-opacity="0.1", stroke-width="1.25222"
    final path3 = Path();
    path3.moveTo(133.379, 41.8683);
    path3.lineTo(129.242, 52.7731);
    path3.cubicTo(127.34, 57.7897, 121.817, 60.4107, 116.727, 58.7126);
    path3.lineTo(105.071, 54.8236);
    path3.cubicTo(100.697, 53.3642, 98.1607, 48.8068, 99.2258, 44.3203);
    path3.lineTo(99.6898, 42.3659);
    path3.cubicTo(100.589, 38.5774, 104.429, 36.2701, 108.196, 37.2543);
    path3.cubicTo(110.569, 37.8742, 112.438, 39.7002, 113.114, 42.0577);
    path3.lineTo(123.004, 76.5832);
    path3.cubicTo(123.678, 78.9337, 123.467, 81.4494, 122.411, 83.6548);
    path3.lineTo(113.799, 101.647);
    path3.cubicTo(112.704, 103.933, 110.187, 105.173, 107.707, 104.646);
    path3.cubicTo(105.268, 104.129, 102.787, 105.319, 101.665, 107.546);
    path3.lineTo(95.1799, 120.415);
    path3.cubicTo(93.6156, 123.519, 90.2057, 125.236, 86.7802, 124.644);
    path3.lineTo(82.9829, 123.988);
    path3.cubicTo(81.3646, 123.708, 79.7816, 124.64, 79.2416, 126.191);
    path3.cubicTo(78.5578, 128.155, 79.8067, 130.262, 81.858, 130.605);
    path3.lineTo(82.7622, 130.756);
    path3.moveTo(82.7622, 130.756);
    path3.lineTo(78.4869, 137.952);
    path3.cubicTo(76.7242, 140.919, 78.3771, 144.741, 81.7461, 145.489);
    path3.cubicTo(83.9885, 145.987, 86.2854, 144.914, 87.3434, 142.875);
    path3.lineTo(88.1365, 141.347);
    path3.cubicTo(90.4221, 136.943, 87.6565, 131.574, 82.7622, 130.756);
    path3.moveTo(83.9774, 139.281);
    path3.lineTo(53.1973, 176.681);

    canvas.drawPath(path3, paint3);

    // Path with #05CAAD stroke-opacity="0.2", stroke-width="1.25222"
    final path4 = Path();
    path4.moveTo(-18.8936, 33.9224);
    path4.lineTo(5.06953, 81.592);
    path4.cubicTo(7.41679, 86.2614, 12.9637, 88.3358, 17.799, 86.3526);
    path4.lineTo(37.7434, 78.1722);
    path4.cubicTo(39.5717, 77.4223, 41.5811, 77.2309, 43.518, 77.6221);
    path4.lineTo(52.7043, 79.4775);
    path4.cubicTo(58.0942, 80.5661, 61.594, 85.8022, 60.5387, 91.1988);
    path4.lineTo(60.3287, 92.2723);

    canvas.drawPath(path4, paint4);

    // Bright teal path (#00FFDA, stroke-width="2.5")
    final path5 = Path();
    path5.moveTo(55.3388, 169.251);
    path5.lineTo(77.0957, 107.179);
    path5.cubicTo(78.6654, 102.701, 83.1659, 99.9424, 87.8686, 100.576);
    path5.lineTo(96.4682, 101.735);
    path5.lineTo(103.965, 103.746);
    path5.cubicTo(108.614, 104.992, 113.491, 102.75, 115.572, 98.4105);
    path5.lineTo(122.251, 84.4813);

    canvas.drawPath(path5, paint5);

    // Draw circles
    // Circle with fill #03DABB fill-opacity="0.33"
    final circleFillPaint = Paint()
      ..color = Color.fromRGBO(3, 218, 187, 0.33) // #03DABB fill-opacity="0.33"
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(115.93, 91.4656),
      7.16631,
      circleFillPaint,
    );

    // Circle with drop shadow (#05CAAD)
    final shadowCirclePaint = Paint()
      ..color = Color.fromRGBO(5, 202, 173, 1.0) // #05CAAD
      ..style = PaintingStyle.fill;

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Color.fromRGBO(5, 202, 173, 0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15.0267);

    canvas.drawCircle(
      Offset(124.726, 80.4612),
      7.16631,
      shadowPaint,
    );

    canvas.drawCircle(
      Offset(124.726, 80.4612),
      7.16631,
      shadowCirclePaint,
    );

    // Bottom circle (#03DABB fill-opacity="0.33")
    canvas.drawCircle(
      Offset(55.7232, 176.765),
      17.4701,
      circleFillPaint,
    );

    // White pin shape at bottom with gradient stroke
    final pinGradient = LinearGradient(
      begin:
          Alignment(0.382, 0.737), // x1="70.0005" y1="165" -> 70/183, 165/224
      end: Alignment(0.257, 0.826), // x2="47.0005" y2="185" -> 47/183, 185/224
      colors: [
        Color.fromRGBO(150, 150, 150, 1.0), // #969696
        Color.fromRGBO(150, 150, 150, 0), // #969696 stop-opacity="0"
      ],
    );

    final pinPath = Path();
    pinPath.moveTo(51.7409, 172.944);
    pinPath.cubicTo(53.5564, 169.467, 58.5378, 169.485, 60.329, 172.974);
    pinPath.lineTo(61.5228, 175.299);
    pinPath.cubicTo(63.173, 178.514, 60.0089, 182.078, 56.6214, 180.82);
    pinPath.lineTo(56.5065, 180.778);
    pinPath.cubicTo(55.9336, 180.565, 55.3046, 180.559, 54.7278, 180.761);
    pinPath.cubicTo(51.6282, 181.846, 48.7996, 178.576, 50.3197, 175.665);
    pinPath.lineTo(51.7409, 172.944);
    pinPath.close();

    final pinPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pinStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = pinGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawPath(pinPath, pinPaint);
    canvas.drawPath(pinPath, pinStrokePaint);
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
      ..color = Color.fromRGBO(7, 7, 7, 0.767) // #040404
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.2);

    canvas.drawOval(
      Rect.fromLTWH(10, 2, size.width, size.height),
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
    final center = Offset(size.width / 2, size.height / 2.15);
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

    final center = Offset(size.width / 2, size.height / 2.15);
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
