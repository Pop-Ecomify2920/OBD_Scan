import 'package:flutter/material.dart';

/// A reusable bottom navigation bar component with custom icons
class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: 95.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.5),
          //     blurRadius: 15.0,
          //     offset: Offset(0, -5),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              index: 0,
              icon: _HomeIcon(isSelected: currentIndex == 0),
            ),
            _buildNavItem(
              index: 1,
              icon: _LocationIcon(isSelected: currentIndex == 1),
            ),
            _buildNavItem(
              index: 2,
              icon: _CarIcon(isSelected: currentIndex == 2),
            ),
            _buildNavItem(
              index: 3,
              icon: _SettingsIcon(isSelected: currentIndex == 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required Widget icon}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: icon,
      ),
    );
  }
}

// Home Icon - Blue fill when selected, white stroke when not
class _HomeIcon extends StatelessWidget {
  final bool isSelected;

  const _HomeIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40.0, 40.0),
      painter: HomeIconPainter(isSelected: isSelected),
    );
  }
}

class HomeIconPainter extends CustomPainter {
  final bool isSelected;

  HomeIconPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Color(0xFF2969CD) : Colors.white
      ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isSelected ? 0 : 2.0;

    final path = Path();
    // Home icon path from SVG
    path.moveTo(36.9728, 19.7266);
    path.lineTo(21.8791, 4.64063);
    path.lineTo(20.8673, 3.62891);
    path.cubicTo(20.6368, 3.39992, 20.3251, 3.27139, 20.0002, 3.27139);
    path.cubicTo(19.6752, 3.27139, 19.3635, 3.39992, 19.133, 3.62891);
    path.lineTo(3.02751, 19.7266);
    path.cubicTo(2.7913, 19.9619, 2.60462, 20.2421, 2.47849, 20.5507);
    path.cubicTo(2.35236, 20.8593, 2.28933, 21.1901, 2.29313, 21.5234);
    path.cubicTo(2.30876, 22.8984, 3.45329, 23.9961, 4.82829, 23.9961);
    path.lineTo(6.48844, 23.9961);
    path.lineTo(6.48844, 36.7188);
    path.lineTo(33.5119, 36.7188);
    path.lineTo(33.5119, 23.9961);
    path.lineTo(35.2072, 23.9961);
    path.cubicTo(35.8752, 23.9961, 36.5041, 23.7344, 36.9767, 23.2617);
    path.cubicTo(37.2095, 23.0297, 37.3939, 22.7539, 37.5192, 22.4501);
    path.cubicTo(37.6446, 22.1464, 37.7085, 21.8208, 37.7072, 21.4922);
    path.cubicTo(37.7072, 20.8281, 37.4455, 20.1992, 36.9728, 19.7266);
    path.close();

    path.moveTo(22.1877, 33.9063);
    path.lineTo(17.8127, 33.9063);
    path.lineTo(17.8127, 25.9375);
    path.lineTo(22.1877, 25.9375);
    path.lineTo(22.1877, 33.9063);
    path.close();

    path.moveTo(30.6994, 21.1836);
    path.lineTo(30.6994, 33.9063);
    path.lineTo(24.6877, 33.9063);
    path.lineTo(24.6877, 25);
    path.cubicTo(24.6877, 24.1367, 23.9884, 23.4375, 23.1252, 23.4375);
    path.lineTo(16.8752, 23.4375);
    path.cubicTo(16.0119, 23.4375, 15.3127, 24.1367, 15.3127, 25);
    path.lineTo(15.3127, 33.9063);
    path.lineTo(9.30094, 33.9063);
    path.lineTo(9.30094, 21.1836);
    path.lineTo(5.55094, 21.1836);
    path.lineTo(20.0041, 6.74219);
    path.lineTo(20.9064, 7.64454);
    path.lineTo(34.4533, 21.1836);
    path.lineTo(30.6994, 21.1836);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Location Icon - White stroke
class _LocationIcon extends StatelessWidget {
  final bool isSelected;

  const _LocationIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40.0, 40.0),
      painter: LocationIconPainter(isSelected: isSelected),
    );
  }
}

class LocationIconPainter extends CustomPainter {
  final bool isSelected;

  LocationIconPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Color(0xFF2969CD) : Colors.white
      ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isSelected ? 0 : 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Location pin icon paths from SVG
    final path = Path();
    path.moveTo(16.5416, 29.6058);
    path.lineTo(11.3441, 29.6058);
    path.cubicTo(10.6298, 29.6058, 10.0508, 30.1849, 10.0508, 30.8992);
    path.lineTo(10.0508, 35.0467);
    path.cubicTo(10.0508, 35.761, 10.6298, 36.34, 11.3441, 36.34);
    path.lineTo(16.5416, 36.34);
    path.cubicTo(17.2559, 36.34, 17.8349, 35.761, 17.8349, 35.0467);
    path.lineTo(17.8349, 30.8992);
    path.cubicTo(17.8349, 30.1849, 17.2559, 29.6058, 16.5416, 29.6058);
    path.close();

    path.moveTo(11.8666, 31.85);
    path.lineTo(17.8349, 31.85);
    path.moveTo(10.0508, 34.095);
    path.lineTo(16.0191, 34.095);

    path.moveTo(13.9379, 29.6058);
    path.cubicTo(14.6522, 29.6058, 15.2312, 29.0268, 15.2312, 28.3125);
    path.cubicTo(15.2312, 27.5982, 14.6522, 27.0192, 13.9379, 27.0192);
    path.cubicTo(13.2236, 27.0192, 12.6445, 27.5982, 12.6445, 28.3125);
    path.cubicTo(12.6445, 29.0268, 13.2236, 29.6058, 13.9379, 29.6058);
    path.close();

    path.moveTo(19.9999, 23.6483);
    path.cubicTo(25.4947, 23.6483, 29.9491, 19.1939, 29.9491, 13.6992);
    path.cubicTo(29.9491, 8.20439, 25.4947, 3.75, 19.9999, 3.75);
    path.cubicTo(14.5052, 3.75, 10.0508, 8.20439, 10.0508, 13.6992);
    path.cubicTo(10.0508, 19.1939, 14.5052, 23.6483, 19.9999, 23.6483);
    path.close();

    path.moveTo(29.9492, 26.3008);
    path.cubicTo(29.9492, 28.9395, 28.901, 31.4701, 27.0351, 33.336);
    path.cubicTo(25.1693, 35.2018, 22.6387, 36.25, 20, 36.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Car/Vehicle Icon - White stroke
class _CarIcon extends StatelessWidget {
  final bool isSelected;

  const _CarIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40.0, 40.0),
      painter: CarIconPainter(isSelected: isSelected),
    );
  }
}

class CarIconPainter extends CustomPainter {
  final bool isSelected;

  CarIconPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Color(0xFF2969CD) : Colors.white
      ..style = isSelected ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isSelected ? 0 : 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Car icon paths from SVG
    final path = Path();
    path.moveTo(32.5, 8.86364);
    path.lineTo(35.8333, 8.86364);
    path.moveTo(32.5, 4.31819);
    path.lineTo(35.8333, 4.31819);
    path.moveTo(35, 21.6667);
    path.cubicTo(35, 29.9509, 28.2843, 36.6667, 20, 36.6667);
    path.cubicTo(11.7157, 36.6667, 5, 29.9509, 5, 21.6667);
    path.cubicTo(5, 13.3824, 11.7157, 6.66666, 20, 6.66666);
    path.lineTo(26.25, 6.66667);
    path.moveTo(13.5655, 20.1929);
    path.lineTo(14.5236, 16.0972);
    path.cubicTo(14.7882, 14.9664, 15.7966, 14.1667, 16.9579, 14.1667);
    path.lineTo(23.0421, 14.1667);
    path.cubicTo(24.2034, 14.1667, 25.2118, 14.9664, 25.4764, 16.0972);
    path.lineTo(26.4345, 20.1929);
    path.moveTo(13.7319, 19.3708);
    path.lineTo(11.6667, 18.3333);
    path.moveTo(26.2681, 19.3708);
    path.lineTo(28.3333, 18.3333);
    path.moveTo(31.7424, 2.42426);
    path.lineTo(30.0379, 2.42426);
    path.cubicTo(29.0333, 2.42425, 28.0698, 2.82333, 27.3594, 3.53369);
    path.cubicTo(26.6491, 4.24405, 26.25, 5.20751, 26.25, 6.21212);
    path.lineTo(26.25, 6.96971);
    path.cubicTo(26.25, 9.0617, 27.9459, 10.7576, 30.0379, 10.7576);
    path.lineTo(31.7424, 10.7576);
    path.cubicTo(31.9433, 10.7576, 32.136, 10.6778, 32.2781, 10.5357);
    path.cubicTo(32.4202, 10.3936, 32.5, 10.2009, 32.5, 9.99999);
    path.lineTo(32.5, 3.18182);
    path.cubicTo(32.5, 2.9809, 32.4202, 2.78821, 32.2781, 2.64614);
    path.cubicTo(32.136, 2.50406, 31.9433, 2.42425, 31.7424, 2.42426);
    path.close();
    path.moveTo(23.3333, 25);
    path.lineTo(16.6667, 25);
    path.lineTo(16.6667, 25.8333);
    path.cubicTo(16.6667, 26.7538, 15.9205, 27.5, 15, 27.5);
    path.lineTo(13.3333, 27.5);
    path.cubicTo(12.4129, 27.5, 11.6667, 26.7538, 11.6667, 25.8333);
    path.lineTo(11.6667, 22.9167);
    path.cubicTo(11.6667, 21.3058, 12.9725, 20, 14.5833, 20);
    path.lineTo(25.4167, 20);
    path.cubicTo(27.0275, 20, 28.3333, 21.3058, 28.3333, 22.9167);
    path.lineTo(28.3333, 25.8333);
    path.cubicTo(28.3333, 26.7538, 27.5871, 27.5, 26.6667, 27.5);
    path.lineTo(25, 27.5);
    path.cubicTo(24.0795, 27.5, 23.3333, 26.7538, 23.3333, 25.8333);
    path.lineTo(23.3333, 25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Settings Icon - White fill
class _SettingsIcon extends StatelessWidget {
  final bool isSelected;

  const _SettingsIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40.0, 40.0),
      painter: SettingsIconPainter(isSelected: isSelected),
    );
  }
}

class SettingsIconPainter extends CustomPainter {
  final bool isSelected;

  SettingsIconPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Color(0xFF2969CD) : Colors.white
      ..style = PaintingStyle.fill;

    // Settings gear icon path from SVG
    final path = Path();
    path.moveTo(36.125, 24.4414);
    path.lineTo(33.5664, 22.2539);
    path.cubicTo(33.6875, 21.5117, 33.75, 20.7539, 33.75, 19.9961);
    path.cubicTo(33.75, 19.2383, 33.6875, 18.4805, 33.5664, 17.7383);
    path.lineTo(36.125, 15.5508);
    path.cubicTo(36.318, 15.3856, 36.4562, 15.1655, 36.521, 14.9199);
    path.cubicTo(36.5859, 14.6743, 36.5745, 14.4148, 36.4883, 14.1758);
    path.lineTo(36.4532, 14.0742);
    path.cubicTo(35.7488, 12.1056, 34.694, 10.2806, 33.3399, 8.6875);
    path.lineTo(33.2696, 8.60547);
    path.cubicTo(33.1053, 8.41231, 32.8864, 8.27346, 32.6416, 8.20722);
    path.cubicTo(32.3968, 8.14097, 32.1377, 8.15044, 31.8985, 8.23438);
    path.lineTo(28.7227, 9.36328);
    path.cubicTo(27.5508, 8.40234, 26.2422, 7.64453, 24.8282, 7.11328);
    path.lineTo(24.2149, 3.79297);
    path.cubicTo(24.1686, 3.54313, 24.0474, 3.31329, 23.8674, 3.13398);
    path.cubicTo(23.6874, 2.95466, 23.4571, 2.83436, 23.2071, 2.78906);
    path.lineTo(23.1016, 2.76953);
    path.cubicTo(21.0664, 2.40234, 18.9258, 2.40234, 16.8906, 2.76953);
    path.lineTo(16.7852, 2.78906);
    path.cubicTo(16.5352, 2.83436, 16.3049, 2.95466, 16.1248, 3.13398);
    path.cubicTo(15.9448, 3.31329, 15.8236, 3.54313, 15.7774, 3.79297);
    path.lineTo(15.1602, 7.12891);
    path.cubicTo(13.7574, 7.66027, 12.4511, 8.41768, 11.293, 9.37109);
    path.lineTo(8.09376, 8.23438);
    path.cubicTo(7.85457, 8.14977, 7.59529, 8.13996, 7.35038, 8.20625);
    path.cubicTo(7.10548, 8.27253, 6.88654, 8.41178, 6.72267, 8.60547);
    path.lineTo(6.65236, 8.6875);
    path.cubicTo(5.2998, 10.2817, 4.24523, 12.1064, 3.53907, 14.0742);
    path.lineTo(3.50391, 14.1758);
    path.cubicTo(3.32813, 14.6641, 3.47266, 15.2109, 3.8672, 15.5508);
    path.lineTo(6.45704, 17.7617);
    path.cubicTo(6.33595, 18.4961, 6.27735, 19.2461, 6.27735, 19.9922);
    path.cubicTo(6.27735, 20.7422, 6.33595, 21.4922, 6.45704, 22.2227);
    path.lineTo(3.8672, 24.4336);
    path.cubicTo(3.67421, 24.5988, 3.53609, 24.8188, 3.4712, 25.0645);
    path.cubicTo(3.4063, 25.3101, 3.41771, 25.5696, 3.50391, 25.8086);
    path.lineTo(3.53907, 25.9102);
    path.cubicTo(4.2461, 27.8789, 5.29298, 29.6953, 6.65236, 31.2969);
    path.lineTo(6.72267, 31.3789);
    path.cubicTo(6.88694, 31.5721, 7.10589, 31.7109, 7.35065, 31.7772);
    path.cubicTo(7.59541, 31.8434, 7.85449, 31.8339, 8.09376, 31.75);
    path.lineTo(11.293, 30.6133);
    path.cubicTo(12.4571, 31.5703, 13.7578, 32.3281, 15.1602, 32.8555);
    path.lineTo(15.7774, 36.1914);
    path.cubicTo(15.8236, 36.4412, 15.9448, 36.6711, 16.1248, 36.8504);
    path.cubicTo(16.3049, 37.0297, 16.5352, 37.15, 16.7852, 37.1953);
    path.lineTo(16.8906, 37.2148);
    path.cubicTo(18.9445, 37.584, 21.0477, 37.584, 23.1016, 37.2148);
    path.lineTo(23.2071, 37.1953);
    path.cubicTo(23.4571, 37.15, 23.6874, 37.0297, 23.8674, 36.8504);
    path.cubicTo(24.0474, 36.6711, 24.1686, 36.4412, 24.2149, 36.1914);
    path.lineTo(24.8282, 32.8711);
    path.cubicTo(26.2416, 32.3412, 27.5576, 31.581, 28.7227, 30.6211);
    path.lineTo(31.8985, 31.75);
    path.cubicTo(32.1377, 31.8346, 32.397, 31.8444, 32.6419, 31.7781);
    path.cubicTo(32.8868, 31.7118, 33.1057, 31.5726, 33.2696, 31.3789);
    path.lineTo(33.3399, 31.2969);
    path.cubicTo(34.6993, 29.6914, 35.7461, 27.8789, 36.4532, 25.9102);
    path.lineTo(36.4883, 25.8086);
    path.cubicTo(36.6641, 25.3281, 36.5196, 24.7813, 36.125, 24.4414);
    path.close();

    // Inner circle
    path.moveTo(30.793, 18.1992);
    path.cubicTo(30.8907, 18.7891, 30.9414, 19.3945, 30.9414, 20);
    path.cubicTo(30.9414, 20.6055, 30.8907, 21.2109, 30.793, 21.8008);
    path.lineTo(30.5352, 23.3672);
    path.lineTo(33.4532, 25.8633);
    path.cubicTo(33.0108, 26.8824, 32.4524, 27.8471, 31.7891, 28.7383);
    path.lineTo(28.1641, 27.4531);
    path.lineTo(26.9375, 28.4609);
    path.cubicTo(26.0039, 29.2266, 24.9649, 29.8281, 23.8399, 30.25);
    path.lineTo(22.3516, 30.8086);
    path.lineTo(21.6524, 34.5977);
    path.cubicTo(20.5491, 34.7227, 19.4353, 34.7227, 18.3321, 34.5977);
    path.lineTo(17.6328, 30.8008);
    path.lineTo(16.1563, 30.2344);
    path.cubicTo(15.043, 29.8125, 14.0078, 29.2109, 13.0821, 28.4492);
    path.lineTo(11.8555, 27.4375);
    path.lineTo(8.20705, 28.7344);
    path.cubicTo(7.54298, 27.8398, 6.98829, 26.875, 6.54298, 25.8594);
    path.lineTo(9.4922, 23.3398);
    path.lineTo(9.2383, 21.7773);
    path.cubicTo(9.14455, 21.1953, 9.09376, 20.5938, 9.09376, 20);
    path.cubicTo(9.09376, 19.4023, 9.14064, 18.8047, 9.2383, 18.2227);
    path.lineTo(9.4922, 16.6602);
    path.lineTo(6.54298, 14.1406);
    path.cubicTo(6.98439, 13.1211, 7.54298, 12.1602, 8.20705, 11.2656);
    path.lineTo(11.8555, 12.5625);
    path.lineTo(13.0821, 11.5508);
    path.cubicTo(14.0078, 10.7891, 15.043, 10.1875, 16.1563, 9.76563);
    path.lineTo(17.6367, 9.20703);
    path.lineTo(18.336, 5.41016);
    path.cubicTo(19.4336, 5.28516, 20.5547, 5.28516, 21.6563, 5.41016);
    path.lineTo(22.3555, 9.19922);
    path.lineTo(23.8438, 9.75781);
    path.cubicTo(24.9649, 10.1797, 26.0078, 10.7813, 26.9414, 11.5469);
    path.lineTo(28.168, 12.5547);
    path.lineTo(31.793, 11.2695);
    path.cubicTo(32.4571, 12.1641, 33.0118, 13.1289, 33.4571, 14.1445);
    path.lineTo(30.5391, 16.6406);
    path.lineTo(30.793, 18.1992);
    path.close();

    path.moveTo(20, 12.7344);
    path.cubicTo(16.2031, 12.7344, 13.125, 15.8125, 13.125, 19.6094);
    path.cubicTo(13.125, 23.4063, 16.2031, 26.4844, 20, 26.4844);
    path.cubicTo(23.7969, 26.4844, 26.875, 23.4063, 26.875, 19.6094);
    path.cubicTo(26.875, 15.8125, 23.7969, 12.7344, 20, 12.7344);
    path.close();

    path.moveTo(23.0938, 22.7031);
    path.cubicTo(22.688, 23.1101, 22.2058, 23.4328, 21.6748, 23.6526);
    path.cubicTo(21.1439, 23.8725, 20.5747, 23.9853, 20, 23.9844);
    path.cubicTo(18.8321, 23.9844, 17.7344, 23.5273, 16.9063, 22.7031);
    path.cubicTo(16.4993, 22.2974, 16.1766, 21.8151, 15.9568, 21.2842);
    path.cubicTo(15.7369, 20.7532, 15.6241, 20.1841, 15.625, 19.6094);
    path.cubicTo(15.625, 18.4414, 16.0821, 17.3438, 16.9063, 16.5156);
    path.cubicTo(17.7344, 15.6875, 18.8321, 15.2344, 20, 15.2344);
    path.cubicTo(21.168, 15.2344, 22.2657, 15.6875, 23.0938, 16.5156);
    path.cubicTo(23.5007, 16.9214, 23.8234, 17.4036, 24.0433, 17.9346);
    path.cubicTo(24.2632, 18.4655, 24.3759, 19.0347, 24.375, 19.6094);
    path.cubicTo(24.375, 20.7773, 23.918, 21.875, 23.0938, 22.7031);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

