import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_clock/widgets/common_widgets/progress_indicator/build_stop_watch.dart';
import 'package:my_clock/widgets/common_widgets/white_button.dart';

class TimerClock extends StatefulWidget {
  const TimerClock(
      {Key? key, required this.initDuraion, required this.changeTimerMode})
      : super(key: key);
  final Duration initDuraion;
  final void Function() changeTimerMode;
  @override
  _TimerClockState createState() => _TimerClockState();
}

class _TimerClockState extends State<TimerClock> {
  late Duration duration;
  double _totalTime = 0, ab = 0;
  bool flag = true;
  var _currentCountDown = const Duration(minutes: 0);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = widget.initDuraion;
    _totalTime = duration.inSeconds.toDouble();
    _startWatch();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Progress Indicator & Time
          BuildStopWatch(
            duration: duration,
            val: duration.inSeconds / _totalTime,
          ),
          const SizedBox(height: 50),
          if (flag)
            InkWell(
              onTap: () => _stopWatch(),
              child: const WhiteButton(text: 'Pause'),
            ),
          if (!flag)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _resumeWatch(),
                  child: const WhiteButton(text: 'Resume'),
                ),
                InkWell(
                  onTap: () => _cancelWatch(),
                  child: const WhiteButton(text: 'Cancel'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _startWatch() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds != 0) {
        if (mounted) {
          setState(() => duration = Duration(seconds: duration.inSeconds - 1));
        }
      } else {
        _cancelWatch();
      }
    });
  }

  void _stopWatch() {
    _currentCountDown = duration;
    timer?.cancel();
    flag = !flag;
    setState(() {});
  }

  void _resumeWatch() {
    duration = _currentCountDown;
    flag = !flag;
    setState(() {});
    _startWatch();
  }

  void _cancelWatch() {
    timer?.cancel();
    widget.changeTimerMode();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
