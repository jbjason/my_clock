import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_clock/models/lap_item.dart';
import 'package:my_clock/widgets/stop_watch_widgets/laptitme_title_all.dart';
import 'package:my_clock/widgets/common_widgets/progress_indicator/build_stop_watch.dart';
import 'package:my_clock/widgets/common_widgets/white_button.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);
  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  var _currentCountDown = const Duration(minutes: 0);
  Duration duration = const Duration(), d = const Duration();
  bool _isStarted = false, _isStopped = false;
  final List<LapItem> lapList = [];
  double _val = 0, _milli = 0;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          BuildStopWatch(duration: duration, val: _milli, size: size),
          const SizedBox(height: 50),
          // lapTime & related title
          LapTimeTitleAll(size: size, lapList: lapList),
          //  !_isPressed means its Visible
          Visibility(
            visible: !_isStarted,
            child: InkWell(
                onTap: _startWatch, child: const WhiteButton(text: 'Start')),
          ),
          _isStarted
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: !_isStopped ? _currentLaptime : _resetWatch,
                      child:
                          WhiteButton(text: !_isStopped ? 'LapTime' : 'Reset'),
                    ),
                    InkWell(
                      onTap: !_isStopped ? _stopWatch : _resumeWatch,
                      child: WhiteButton(text: !_isStopped ? 'Stop' : 'Resume'),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  void _startWatch() {
    setState(() => _isStarted = true);
    timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      if (mounted) {
        setState(() {
          _val += 40;
          _milli = (_val % 1000) / 1000;
          duration = Duration(seconds: _val ~/ 1000);
        });
      }
    });
  }

  void _stopWatch() {
    setState(() {
      _isStopped = !_isStopped; //_isStopped true hobe
      _currentCountDown = duration;
      timer?.cancel();
    });
  }

  // Resume & Reset will appear in same Time
  void _resumeWatch() {
    setState(() {
      duration = _currentCountDown;
      _isStopped = false;
    });
    _startWatch();
  }

  void _resetWatch() {
    setState(() {
      duration = const Duration();
      timer?.cancel();
      _isStarted = false;
      _isStopped = false;
      _val = 0;
      _milli = 0;
    });
  }

  void _currentLaptime() {
    d = duration - d;
    lapList.add(LapItem(lapTime: d, overallTime: duration));
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}
