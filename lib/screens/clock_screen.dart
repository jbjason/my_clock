import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_clock/widgets/clock_widgets/blue_shadow_container.dart';
import 'package:my_clock/widgets/clock_widgets/clock_painter.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100),
        Center(
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
        ),
      ],
    );
  }

  Widget _weatherBody() {
    return Container();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
