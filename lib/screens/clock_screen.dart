import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_clock/widgets/clock_widgets/blue_shadow_container.dart';
import 'package:my_clock/widgets/clock_widgets/white_shadow_container.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const BlueShadowContainer(),
            const WhiteShadowContainer(),
            Transform.rotate(
              angle: pi / 2,
              child: Container(
                //It paints a box which expands to fill its parent widget
                constraints: const BoxConstraints.expand(),
                child: CustomPaint(
                  painter: ClockPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerY, centerX);

    Paint dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Paint secdashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double outerRadius = radius - 20;
    double innerRadius = radius - 30;
    for (int i = 0; i < 360; i += 30) {
      double x1 = centerX - outerRadius * cos(i * pi / 180);
      double y1 = centerX - outerRadius * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashPaint);
    }
    for (int i = 0; i < 360; i += 6) {
      double x1 = centerX - outerRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - outerRadius * .95 * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), secdashPaint);
    }

    DateTime dateTime = DateTime.now();

    Offset secondStartOffset = Offset(
      centerX - outerRadius * cos(dateTime.second * 6 * pi / 180),
      centerX - outerRadius * sin(dateTime.second * 6 * pi / 180),
    );
    Offset secondEndOffset = Offset(
      centerX + 20 * cos(dateTime.second * 6 * pi / 180),
      centerX + 20 * sin(dateTime.second * 6 * pi / 180),
    );

    Offset minStartOffset = Offset(
      centerX - outerRadius * .6 * cos(dateTime.minute * 6 * pi / 180),
      centerX - outerRadius * .6 * sin(dateTime.minute * 6 * pi / 180),
    );
    Offset minEndOffset = Offset(
      centerX + 20 * cos(dateTime.minute * 6 * pi / 180),
      centerX + 20 * sin(dateTime.minute * 6 * pi / 180),
    );

    Offset hourStartOffset = Offset(
      centerX - outerRadius * .4 * cos(dateTime.hour * 6 * pi / 180),
      centerX - outerRadius * .4 * sin(dateTime.hour * 6 * pi / 180),
    );
    Offset hourEndOffset = Offset(
      centerX + 20 * cos(dateTime.hour * 6 * pi / 180),
      centerX + 20 * sin(dateTime.hour * 6 * pi / 180),
    );

    Paint centerCirclePaint = Paint()..color = const Color(0xFFE81466);
    Paint secondPaint = Paint()
      ..color = const Color(0xFFE81466)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    Paint minPaint = Paint()
      ..color = const Color(0xFFBEC5D5)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    Paint hourPaint = Paint()
      ..color = const Color(0xFF222E63)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(minStartOffset, minEndOffset, minPaint);
    canvas.drawLine(hourStartOffset, hourEndOffset, hourPaint);
    canvas.drawLine(secondStartOffset, secondEndOffset, secondPaint);
    canvas.drawCircle(center, 4, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
