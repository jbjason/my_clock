import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_clock/widgets/progress_indicator/build_stop_watch.dart';
import 'package:my_clock/widgets/timer_widgets/white_button.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/start_bottom_button.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? timer;
  Duration duration = const Duration(seconds: 0);
  var _currentCountDown = const Duration(minutes: 0);
  bool _flag = false, _isStopped = true;

  void _startWatch() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _flag = true;
      setState(() => duration = Duration(microseconds: duration.inSeconds + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BuildStopWatch(duration: duration, val: 1 / 1000),
        if (!_flag)
          InkWell(
            onTap: () => _startWatch(),
            child: const StartButtonBottom(),
          ),
        if (_flag)
          InkWell(
            onTap: () => _stopWatch(),
            child: const WhiteButton(text: 'Pause'),
          ),
        if (_flag && !_isStopped)
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
    );
  }

  void _stopWatch() {
    setState(() {
      _currentCountDown = duration;
      timer?.cancel();
      _isStopped = !_isStopped;
    });
  }

  void _resumeWatch() {
    setState(() {
      duration = _currentCountDown;
      _isStopped = !_isStopped;
    });
    _startWatch();
  }

  void _cancelWatch() {
    timer?.cancel();
    setState(() {
      duration = const Duration(seconds: 0);
    });
  }
}
