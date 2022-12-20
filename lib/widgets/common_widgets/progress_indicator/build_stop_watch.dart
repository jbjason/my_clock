import 'package:flutter/material.dart';
import 'package:my_clock/widgets/common_widgets/progress_indicator/build_time.dart';
import 'package:vector_math/vector_math.dart' as math;

class BuildStopWatch extends StatelessWidget {
  const BuildStopWatch({Key? key, required this.duration, required this.val})
      : super(key: key);
  final Duration duration;
  final double val;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .8,
      height: size.height * .4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // circular progress indicator
          CustomPaint(painter: CirularPainter(val: val)),
          // Current time ,situated inside of the ProgressIndicator
          Center(child: BuildTime(duration: duration)),
        ],
      ),
    );
  }
}

class CirularPainter extends CustomPainter {
  const CirularPainter({required this.val});
  final double val;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final center = Offset(w / 2, h / 2);
    final progress = 360 * val;

    final gradient = SweepGradient(
      tileMode: TileMode.repeated,
      startAngle: math.radians(270),
      endAngle: math.radians(270 + 360),
      colors: [
        Colors.blue[200]!.withOpacity(.1),
        Colors.blue[200]!.withOpacity(.25),
        Colors.blue[200]!.withOpacity(0.6),
        Colors.blue[200]!.withOpacity(0.75),
        Colors.blue[200]!.withOpacity(0.85),
      ],
    );
    final rect = Rect.fromCenter(center: center, width: w, height: h);
    final paint = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30
      ..shader = gradient.createShader(rect);

    canvas.drawArc(rect, 0, 360, false, paint);
    canvas.drawArc(
        rect, math.radians(270), math.radians(progress), false, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
