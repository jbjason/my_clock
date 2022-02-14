import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_clock/widgets/progress_indicator/build_stop_watch.dart';
import 'package:my_clock/widgets/timer_widgets/countdown_screen/white_button.dart';

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

  void _startWatch() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds != 0) {
        setState(() => duration = Duration(seconds: duration.inSeconds - 1));
      } else {
        timer!.cancel();
      }
    });
  }

  void _stopWatch() {
    setState(() {
      _currentCountDown = duration;
      timer?.cancel();
      flag = !flag;
    });
  }

  void _resumeWatch() {
    setState(() {
      duration = _currentCountDown;
      flag = !flag;
    });
    _startWatch();
  }

  void _cancelWatch() {
    timer?.cancel();
    widget.changeTimerMode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildStopWatch(
            duration: duration,
            totalTime: _totalTime,
            val: duration.inSeconds / _totalTime,
          ),
          const SizedBox(height: 50),
          if (flag)
            InkWell(
              onTap: () => _stopWatch(),
              child: WhiteButton(isTrue: flag, text: 'Pause'),
            ),
          if (!flag)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _resumeWatch(),
                  child: WhiteButton(isTrue: flag, text: 'Resume'),
                ),
                InkWell(
                  onTap: () => _cancelWatch(),
                  child: WhiteButton(isTrue: flag, text: 'Cancel'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

