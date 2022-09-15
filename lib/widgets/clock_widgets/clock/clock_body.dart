import 'dart:async';
import 'package:my_clock/widgets/clock_widgets/clock/blue_shadow_container.dart';
import 'package:my_clock/widgets/clock_widgets/clock/clock_painter.dart';
import 'package:my_clock/widgets/clock_widgets/clock/white_shadow_container.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockBody extends StatefulWidget {
  const ClockBody({Key? key}) : super(key: key);
  @override
  State<ClockBody> createState() => _ClockBodyState();
}

class _ClockBodyState extends State<ClockBody> {
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
    return Stack(
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
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
