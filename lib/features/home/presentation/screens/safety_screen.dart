import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/bottom_navigation_bar.dart';
import '../../../../shared/widgets/error_boundary.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import 'home_dashboard_screen.dart'; // Import for MenuIconPainter and NotificationIconPainter

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  int _currentIndex = 1; // Default to safety index

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
    return 1; // Default to safety index
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
        // Already on safety
         context.go(RouteNames.safety);
        break;
      case 2:
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
                      height: 798,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Header
                          _buildHeader(context, screenWidth),
                          // Car image
                          _buildCarImage(screenWidth),
                          // Lock icons
                          _buildLockIcons(screenWidth),
                          // Auto Lock section
                          _buildAutoLockSection(screenWidth),
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

  Widget _buildCarImage(double screenWidth) {
    // Position car image - HTML shows left-[298.5px] which is off-screen for 430px width
    // Adjusting to position it properly
    return Positioned(
      left: 125.5,
      top: 200.5,
      child: ErrorBoundary(
        child: Image.asset(
          'assets/images/Aura3.png',
          width: 166.0,
          height: 383.0,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 383.0,
              height: 166.0,
              color: Colors.grey.withOpacity(0.3),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLockIcons(double screenWidth) {
    return Stack(
      children: [
        // Lock icon 1 (top right) - HTML: left-[318px] top-[407px]
        Positioned(
          left: 318.0 - 7.5, // Adjust for screen padding
          top: 350.0,
          child: _buildLockIconButton(),
        ),
        // Lock icon 2 (bottom left) - HTML: left-[183px] top-[558px]
        Positioned(
          left: 183.0 - 7.5,
          top: 500.0,
          child: _buildLockIconButton(),
        ),
        // Lock icon 3 (top left) - HTML: left-[183px] top-[282px]
        Positioned(
          left: 183.0 - 7.5,
          top: 225.0,
          child: _buildLockIconButton(),
        ),
      ],
    );
  }

  Widget _buildLockIconButton() {
    return SizedBox(
      width: 70.0,
      height: 70.0,
      child: Stack(
        children: [
          // Background circle
          CustomPaint(
            size: Size(70.0, 70.0),
            painter: LockIconBackgroundPainter(),
          ),
          // Lock icon
          Center(
            child: CustomPaint(
              size: Size(25.0, 25.0),
              painter: LockIconPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoLockSection(double screenWidth) {
    return Positioned(
      left: 46.0 - 13.5, // Adjust for screen padding
      top: 348.0,
      child: ErrorBoundary(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock icon with progress ring
            SizedBox(
              width:75.0, // Increased to accommodate stroke width
              height: 75.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background circle with teal fill (centered)
                  Positioned(
                    left: (85.0 - 76.0) / 2,
                    top: (85.0 - 80.5) / 2,
                    child: SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: CustomPaint(
                        painter: AutoLockBackgroundPainter(),
                      ),
                    ),
                  ),
                  // Progress ring (centered with padding for stroke)
                  Positioned(
                    left: (85.0 - 86.0) / 2, // Center 82x82 in 85x85
                    top: (85.0 - 85) / 2,
                    child: SizedBox(
                      width: 75.0, // Increased to accommodate full stroke width
                      height: 75.0,
                      child: CustomPaint(
                        painter: AutoLockProgressPainter(),
                      ),
                    ),
                  ),
                  // Lock icon (centered)
                  Center(
                    child: CustomPaint(
                      size: Size(25.0, 25.0),
                      painter: LockIconPainter(isWhite: true),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            // AUTO LOCK text
            Text(
              "AUTO LOCK",
              style: GoogleFonts.inter(
                fontSize: 12.0,
                color: Color.fromRGBO(193, 193, 193, 1.0), // #c1c1c1
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 4.0),
            // Timer text
            Text(
              "00:24",
              style: GoogleFonts.inter(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Lock Icon Background Painter (white with opacity)
class LockIconBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Auto Lock Background Painter (teal fill)
class AutoLockBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(5, 202, 173, 0.5) // #05CAAD with 0.5 opacity
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Auto Lock Progress Ring Painter
class AutoLockProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(1, 188, 177, 1.0), // #01BCB1
        Color.fromRGBO(0, 255, 217, 1.0), // #00FFD9
      ],
    );

    final strokeWidth = 6.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // Center the arc in the canvas
    final center = Offset(size.width / 2, size.height / 2);
    // Calculate radius to ensure stroke doesn't get clipped
    // Use half the size minus half the stroke width to keep stroke within bounds
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Draw arc from top (270 degrees) to approximately 3/4 around (90 degrees)
    // This creates a progress ring that goes from top, around right, to bottom
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -5.1708, // Start at top (-90 degrees = -π/2)
      3.5124, // 270 degrees = 3π/2 (3/4 of circle)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Lock Icon Painter
class LockIconPainter extends CustomPainter {
  final bool isWhite;

  LockIconPainter({this.isWhite = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isWhite ? Colors.white : Color.fromRGBO(186, 186, 186, 1.0) // #BABABA
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Scale factor to fit in 40x40 size (original is 30x30 in SVG)
    final scale = size.width / 30.0;
    canvas.save();
    canvas.scale(scale);

    // Lock icon path from SVG
    // Lock top (rounded rectangle at top)
    final lockTopRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(9.0, 6.0, 12.0, 8.0),
      Radius.circular(2.0),
    );
    canvas.drawRRect(lockTopRect, paint);

    // Lock body (rectangle)
    final lockBodyRect = Rect.fromLTWH(6.0, 13.0, 18.0, 14.0);
    canvas.drawRect(lockBodyRect, paint);

    // Keyhole vertical line
    canvas.drawLine(
      Offset(15.0, 17.0),
      Offset(15.0, 20.0),
      paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

