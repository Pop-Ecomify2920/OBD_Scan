import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import '../../../../shared/widgets/error_boundary.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import '../../../home/presentation/screens/home_dashboard_screen.dart'; // For MenuIconPainter and NotificationIconPainter

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 3; // Default to settings index

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Determine current index based on route
    _currentIndex = _getIndexFromRoute();
  }

  int _getIndexFromRoute() {
    final location = GoRouterState.of(context).uri.path;
    if (location == RouteNames.home) return 0;
    if (location == RouteNames.safety) return 1;
    if (location == RouteNames.homeDashboard) return 2;
    if (location == RouteNames.settings) return 3;
    return 3; // Default to settings index
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate based on index
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.safety);
        break;
      case 2:
        context.go(RouteNames.homeDashboard);
        break;
      case 3:
        // Already on settings
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
                      height: 996,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Header
                          _buildHeader(context, screenWidth),
                          // Car image with blur
                          _buildCarImage(screenWidth),
                          // Stat cards
                          _buildStatCards(screenWidth),
                          // Service cards
                          _buildServiceCards(screenWidth),
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
      top: 14.0,
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
            // Title
            Text(
              "Setting",
              style: GoogleFonts.inter(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
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

  Widget _buildCarImage(double screenWidth) {
    return Stack(
      children: [
        // Blur effect ellipse
        Positioned(
          left: 91.69 - 15.0, // Adjust for padding
          top: 185,
          child: CustomPaint(
            size: Size(257.0, 19.0),
            painter: CarBlurPainter(),
          ),
        ),
        // Car image
        Positioned(
          left: (screenWidth - 281.0) / 2,
          top: 93.5,
          child: ErrorBoundary(
            child: Image.asset(
              'assets/images/aura2-3.png',
              width: 283.0,
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
          ),
        ),
      ],
    );
  }

  Widget _buildStatCards(double screenWidth) {
    return Positioned(
      left: 11.0,
      top: 240.0,
      child: Row(
        children: [
          _buildStatCard("AVG. SPEED", "68 kph"),
          SizedBox(width: 17.0),
          _buildStatCard("DISTANCE", "45,721 km"),
          SizedBox(width: 17.0),
          _buildStatCard("CONSUMPTION", "32 MPG"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      width: 119.0,
      height: 63.0,
      padding: EdgeInsets.symmetric(vertical: 13.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(83, 82, 82, 0.486), // #292929
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(201, 198, 198, 1), // neutral-400
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCards(double screenWidth) {
    return Positioned(
      left: 11.0,
      top: 324.0,
      
      child: Column(
        
        children: [
          Row(
            children: [
              _buildServiceCard(
                "VEHICLE",
                VehicleIconPainter(),
                Color.fromRGBO(19, 166, 222, 1.0), // #13A6DE - Blue theme color
                [
                  Color.fromRGBO(107, 106, 106, 0.129),
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(19, 166, 222, 0),
                  Color.fromRGBO(19, 166, 222, 0.2),
                ],
                [0.0, 0.39, 0.74, 0.95],
                onTap: () {
                  context.push(RouteNames.carSelection);
                },
              ),
            ],
          ),
          SizedBox(height: 25.0),
          Row(
            children: [
              _buildServiceCard(
                "MANUAL",
                ManualIconPainter(),
                Color.fromRGBO(5, 202, 173, 1.0), // #05CAAD
                [
                  Color.fromRGBO(209, 205, 205, 0.137),
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(5, 202, 173, 0),
                  Color.fromRGBO(5, 202, 173, 0.2),
                ],
                [0.0, 0.39, 0.76, 0.98],
              ),
              SizedBox(width: 24.0),
              _buildServiceCard(
                "SUPPORT",
                SupportIconPainter(),
                Color.fromRGBO(167, 169, 169, 1.0), // #A7A9A9
                [
                  Color.fromRGBO(204, 201, 201, 0.137),
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(167, 169, 169, 0),
                  Color.fromRGBO(255, 255, 255, 0.2),
                ],
                [0.0, 0.41, 0.74, 1.02],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              _buildServiceCard(
                "SERVICE",
                ServiceIconPainter(),
                Color.fromRGBO(9, 217, 232, 1.0), // #09D9E8
                [
                  Color.fromRGBO(201, 197, 197, 0.137),
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(9, 217, 232, 0),
                  Color.fromRGBO(9, 217, 232, 0.2),
                ],
                [0.0, 0.38, 0.74, 0.96],
              ),
              SizedBox(width: 24.0),
              _buildServiceCard(
                "LOG",
                LogIconPainter(),
                Color.fromRGBO(235, 1, 206, 1.0), // #EB01CE
                [
                  Color.fromRGBO(131, 130, 130, 0.133),
                  Color.fromRGBO(255, 255, 255, 0),
                  Color.fromRGBO(235, 1, 206, 0),
                  Color.fromRGBO(235, 1, 206, 0.2),
                ],
                [0.0, 0.39, 0.74, 0.95],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    CustomPainter iconPainter,
    Color iconColor,
    List<Color> gradientColors,
    List<double> gradientStops, {
    VoidCallback? onTap,
  }) {
    // Convert HTML gradient angles to Flutter Alignment
    // 198.14deg = from top-right to bottom-left
    // Using approximate alignments based on HTML angles
    Alignment begin = Alignment.topCenter;
    Alignment end = Alignment.bottomCenter;

    // Adjust based on card type for better gradient match
    if (title == "SERVICE") {
      // 198.14deg - slightly angled
      begin = Alignment(0.1, -1.0);
      end = Alignment(-0.1, 1.0);
    } else if (title == "LOG") {
      // 195.92deg - slightly angled
      begin = Alignment(0.15, -1.0);
      end = Alignment(-0.15, 1.0);
    } else if (title == "MANUAL") {
      // 182.54deg - almost vertical
      begin = Alignment(-0.1, -1.0);
      end = Alignment(0.1, 1.0);
    } else if (title == "SUPPORT") {
      // 196.99deg - slightly angled
      begin = Alignment(0.12, -1.0);
      end = Alignment(-0.12, 1.0);
    } else if (title == "VEHICLE") {
      // Similar to SERVICE
      begin = Alignment(0.1, -1.0);
      end = Alignment(-0.1, 1.0);
    }

    Widget card = Container(
      width: 183.0,
      height: 187.0,
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24.0,
        right: 24.0,
        bottom: 8.0, // Reduced bottom padding to make room for arrow button
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: gradientColors,
          stops: gradientStops,
        ),
      ),
      child: Stack(
        clipBehavior:
            Clip.none, // Allow arrow button to extend slightly outside
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title - centered
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 14.0),
              // Icon - centered
              Center(
                child: SizedBox(
                  width: 64.0,
                  height: 64.0,
                  child: CustomPaint(
                    painter: iconPainter,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          // Arrow button positioned at bottom-right (partially outside for visual effect)
          Positioned(
            bottom: 1,
            right: -13,
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: Stack(
                children: [
                  // Background circle with blur effect
                  CustomPaint(
                    size: Size(40.0, 40.0),
                    painter: ArrowButtonBackgroundPainter(),
                  ),
                  // Arrow icon (centered)
                  Center(
                    child: CustomPaint(
                      size: Size(30.0, 30.0),
                      painter: ArrowIconPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }
    return card;
  }
}

// Vehicle Icon Painter
class VehicleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(19, 166, 222, 1.0) // #13A6DE - Blue theme color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Car/vehicle icon path - simplified car outline
    final path = Path();
    // Car body (top view)
    path.moveTo(16.0, 32.0);
    path.lineTo(20.0, 24.0);
    path.lineTo(44.0, 24.0);
    path.lineTo(48.0, 32.0);
    path.lineTo(48.0, 40.0);
    path.lineTo(44.0, 44.0);
    path.lineTo(20.0, 44.0);
    path.lineTo(16.0, 40.0);
    path.close();

    // Front wheel
    path.addOval(Rect.fromCircle(center: Offset(24.0, 40.0), radius: 4.0));
    // Rear wheel
    path.addOval(Rect.fromCircle(center: Offset(40.0, 40.0), radius: 4.0));

    final scale = size.width / 57.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Car Blur Painter
class CarBlurPainter extends CustomPainter {
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

// Service Icon Painters
class ServiceIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(19, 166, 222, 1.0) // #13A6DE
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Wrench/service icon path from SVG
    final path = Path();
    path.moveTo(22.0, 30.6667);
    path.lineTo(16.6667, 30.6667);
    path.moveTo(47.688, 22.1173);
    path.lineTo(53.3333, 19.2933);
    path.moveTo(13.648, 22.1173);
    path.lineTo(8.0, 19.2933);
    path.moveTo(47.8669, 23.0814);
    path.lineTo(45.2969, 12.1163);
    path.cubicTo(44.7318, 9.70498, 42.581, 7.99999, 40.1043, 8.0);
    path.lineTo(21.229, 8.0);
    path.cubicTo(18.7523, 8.0, 16.6016, 9.70499, 16.0364, 12.1163);
    path.lineTo(13.4665, 23.0814);
    path.moveTo(39.3333, 30.6667);
    path.lineTo(44.6667, 30.6667);
    path.moveTo(53.3333, 32.0);
    path.lineTo(53.3333, 30.6667);
    path.cubicTo(53.3333, 26.2484, 49.7516, 22.6667, 45.3333, 22.6667);
    path.lineTo(16.0, 22.6667);
    path.cubicTo(11.5817, 22.6667, 8.0, 26.2484, 8.0, 30.6667);
    path.lineTo(8.0, 42.6667);
    path.cubicTo(8.0, 44.1394, 9.19391, 45.3333, 10.6667, 45.3333);
    path.lineTo(16.6293, 45.3333);
    path.cubicTo(18.1021, 45.3333, 19.296, 44.1394, 19.296, 42.6667);
    path.lineTo(19.296, 38.6667);
    path.lineTo(34.6667, 38.6667);
    path.moveTo(48.0, 40.0);
    path.lineTo(48.0, 43.3333);
    path.moveTo(48.0, 43.3333);
    path.cubicTo(44.6863, 43.3333, 42.0, 46.0196, 42.0, 49.3333);
    path.cubicTo(42.0, 52.647, 44.6863, 55.3333, 48.0, 55.3333);
    path.moveTo(48.0, 43.3333);
    path.cubicTo(51.3137, 43.3333, 54.0, 46.0196, 54.0, 49.3333);
    path.cubicTo(54.0, 52.647, 51.3137, 55.3333, 48.0, 55.3333);
    path.moveTo(48.0, 55.3333);
    path.lineTo(48.0, 58.6667);
    path.moveTo(53.1961, 52.3333);
    path.lineTo(56.0, 53.9522);
    path.moveTo(56.0, 44.7145);
    path.lineTo(53.1961, 46.3333);
    path.moveTo(42.8039, 46.3333);
    path.lineTo(40.0, 44.7145);
    path.moveTo(40.0, 53.9522);
    path.lineTo(42.8039, 52.3333);

    // Scale from 64x64 to actual size
    final scale = size.width / 64.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LogIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(244, 1, 220, 1.0) // #F401DC
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Log/document icon path from SVG
    final path = Path();
    path.moveTo(53.3333, 26.6667);
    path.lineTo(53.3333, 13.3333);
    path.cubicTo(53.3333, 10.3878, 50.9455, 8.0, 48.0, 8.0);
    path.lineTo(13.3333, 8.0);
    path.cubicTo(10.3878, 8.0, 8.0, 10.3878, 8.0, 13.3333);
    path.lineTo(8.0, 50.6667);
    path.cubicTo(8.0, 53.6122, 10.3878, 56.0, 13.3333, 56.0);
    path.lineTo(21.3333, 56.0);
    path.moveTo(18.6667, 21.3333);
    path.lineTo(42.6667, 21.3333);
    path.moveTo(18.6667, 32.0);
    path.lineTo(26.6667, 32.0);
    path.moveTo(18.6667, 42.6667);
    path.lineTo(21.3333, 42.6667);
    path.moveTo(35.0381, 44.3086);
    path.lineTo(36.5711, 37.7555);
    path.cubicTo(36.9944, 35.9462, 38.6079, 34.6667, 40.466, 34.6667);
    path.lineTo(50.2007, 34.6667);
    path.cubicTo(52.0588, 34.6667, 53.6723, 35.9462, 54.0955, 37.7555);
    path.lineTo(55.6286, 44.3086);
    path.moveTo(35.3043, 42.9933);
    path.lineTo(32.0, 41.3333);
    path.moveTo(55.3623, 42.9933);
    path.lineTo(58.6667, 41.3333);
    path.moveTo(50.6667, 52.0);
    path.lineTo(40.0, 52.0);
    path.lineTo(40.0, 53.3333);
    path.cubicTo(40.0, 54.8061, 38.8061, 56.0, 37.3333, 56.0);
    path.lineTo(34.6667, 56.0);
    path.cubicTo(33.1939, 56.0, 32.0, 54.8061, 32.0, 53.3333);
    path.lineTo(32.0, 48.6667);
    path.cubicTo(32.0, 46.0893, 34.0893, 44.0, 36.6667, 44.0);
    path.lineTo(54.0, 44.0);
    path.cubicTo(56.5773, 44.0, 58.6667, 46.0893, 58.6667, 48.6667);
    path.lineTo(58.6667, 53.3333);
    path.cubicTo(58.6667, 54.8061, 57.4728, 56.0, 56.0, 56.0);
    path.lineTo(53.3333, 56.0);
    path.cubicTo(51.8606, 56.0, 50.6667, 54.8061, 50.6667, 53.3333);
    path.lineTo(50.6667, 52.0);
    path.close();

    final scale = size.width / 64.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ManualIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(5, 202, 173, 1.0) // #05CAAD
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Manual/book icon path from SVG
    final path = Path();
    path.moveTo(50.6667, 26.6667);
    path.lineTo(50.6667, 13.3333);
    path.cubicTo(50.6667, 10.3878, 48.2789, 8.0, 45.3333, 8.0);
    path.lineTo(13.3333, 8.0);
    path.cubicTo(10.3878, 8.0, 8.0, 10.3878, 8.0, 13.3333);
    path.lineTo(8.0, 50.6667);
    path.moveTo(8.0, 50.6667);
    path.cubicTo(8.0, 47.7211, 10.3878, 45.3333, 13.3333, 45.3333);
    path.lineTo(24.0, 45.3333);
    path.moveTo(8.0, 50.6667);
    path.cubicTo(8.0, 53.6122, 10.3878, 56.0, 13.3333, 56.0);
    path.lineTo(24.0, 56.0);
    path.moveTo(18.6667, 8.0);
    path.lineTo(18.6667, 45.3333);
    path.moveTo(35.0381, 44.3086);
    path.lineTo(36.5711, 37.7555);
    path.cubicTo(36.9944, 35.9462, 38.6079, 34.6667, 40.466, 34.6667);
    path.lineTo(50.2007, 34.6667);
    path.cubicTo(52.0588, 34.6667, 53.6723, 35.9462, 54.0955, 37.7555);
    path.lineTo(55.6286, 44.3086);
    path.moveTo(35.3043, 42.9934);
    path.lineTo(32.0, 41.3333);
    path.moveTo(55.3623, 42.9934);
    path.lineTo(58.6667, 41.3333);
    path.moveTo(50.6667, 52.0);
    path.lineTo(40.0, 52.0);
    path.lineTo(40.0, 53.3333);
    path.cubicTo(40.0, 54.8061, 38.8061, 56.0, 37.3333, 56.0);
    path.lineTo(34.6667, 56.0);
    path.cubicTo(33.1939, 56.0, 32.0, 54.8061, 32.0, 53.3333);
    path.lineTo(32.0, 48.6667);
    path.cubicTo(32.0, 46.0893, 34.0893, 44.0, 36.6667, 44.0);
    path.lineTo(54.0, 44.0);
    path.cubicTo(56.5773, 44.0, 58.6667, 46.0893, 58.6667, 48.6667);
    path.lineTo(58.6667, 53.3333);
    path.cubicTo(58.6667, 54.8061, 57.4728, 56.0, 56.0, 56.0);
    path.lineTo(53.3333, 56.0);
    path.cubicTo(51.8606, 56.0, 50.6667, 54.8061, 50.6667, 53.3333);
    path.lineTo(50.6667, 52.0);
    path.close();

    final scale = size.width / 64.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SupportIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(120, 120, 120, 1.0) // #787878
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Support/headset icon path from SVG
    final path = Path();
    path.moveTo(18.8659, 52.0672);
    path.lineTo(28.5615, 42.3716);
    path.cubicTo(33.2303, 44.1092, 38.4858, 42.8852, 41.9065, 39.2636);
    path.cubicTo(45.3273, 35.642, 46.2497, 30.3254, 44.2488, 25.7631);
    path.cubicTo(44.2178, 25.7009, 44.1592, 25.657, 44.0907, 25.6448);
    path.cubicTo(44.0223, 25.6326, 43.9521, 25.6534, 43.9015, 25.7011);
    path.lineTo(35.7663, 33.6471);
    path.lineTo(30.0751, 27.9559);
    path.lineTo(38.0087, 20.0223);
    path.cubicTo(38.0582, 19.9716, 38.0799, 19.8999, 38.0669, 19.8302);
    path.cubicTo(38.054, 19.7605, 38.0079, 19.7014, 37.9435, 19.6719);
    path.cubicTo(33.2596, 17.6608, 27.8244, 18.6858, 24.1947, 22.2647);
    path.cubicTo(20.7157, 25.6666, 19.5972, 30.8138, 21.3506, 35.3528);
    path.lineTo(11.7816, 44.9219);
    path.moveTo(56.0102, 32.0);
    path.cubicTo(56.0102, 45.2603, 45.2606, 56.01, 32.0002, 56.01);
    path.cubicTo(18.7399, 56.01, 7.99023, 45.2603, 7.99023, 32.0);
    path.cubicTo(7.99023, 18.7396, 18.7399, 7.98999, 32.0002, 7.98999);
    path.cubicTo(45.2606, 7.98999, 56.0102, 18.7396, 56.0102, 32.0);
    path.close();

    final scale = size.width / 64.0;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Arrow Button Background Painter
class ArrowButtonBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Center the circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Arrow Icon Painter
class ArrowIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(201, 199, 199, 1) // #BABABA
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Arrow path from SVG (original coordinates in 40x40 space)
    final path = Path();
    path.moveTo(18.5, 25.1053);
    path.lineTo(24.5, 20.0526);
    path.lineTo(18.5, 15.0);

    // Calculate the bounding box center of the arrow
    // Min X: 18.5, Max X: 24.5, Min Y: 15.0, Max Y: 25.1053
    final arrowCenterX = (18.5 + 59.5) / 2; // 21.5
    final arrowCenterY = (15.0 + 65.1053) / 2; // 20.05265

    // Original space center is (20, 20)
    // Offset needed to center the arrow
    final offsetX = 20.0 - arrowCenterX; // -1.5
    final offsetY = 20.0 - arrowCenterY; // -0.05265

    // Scale factor from 40x40 to target size
    final scale = size.width / 40.0;

    // Target center
    final targetCenterX = size.width / 2;
    final targetCenterY = size.height / 2;

    canvas.save();
    // Translate to target center
    canvas.translate(targetCenterX, targetCenterY);
    // Scale
    canvas.scale(scale);
    // Translate to center the arrow in original space
    canvas.translate(offsetX, offsetY);
    // Draw the path
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
