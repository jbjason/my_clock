import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_clock/models/lap_item.dart';
import 'package:my_clock/widgets/progress_indicator/build_stop_watch.dart';
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
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final value = (duration.inSeconds / 60);
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          BuildStopWatch(
            duration: duration,
            val: value - value.toInt(),
            size: size,
          ),
          const SizedBox(height: 50),
          // lapTime & related title
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: size.height * .2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Lap', style: TextStyle(fontWeight: FontWeight.w400)),
                    Text('Lap Time',
                        style: TextStyle(fontWeight: FontWeight.w400)),
                    Text('Overall Time',
                        style: TextStyle(fontWeight: FontWeight.w400)),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                        color: Colors.grey.withOpacity(0.5), thickness: 1.5)),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text((i + 1).toString()),
                            Text(_formatDuration(lapList[i].lapTime)),
                            Text(_formatDuration(lapList[i].overallTime)),
                          ],
                        ),
                      );
                    },
                    itemCount: lapList.length,
                  ),
                ),
              ],
            ),
          ),
          //  !_isPressed means its Visible
          Visibility(
            visible: !_isStarted,
            child: InkWell(
              onTap: _startWatch,
              child: const WhiteButton(text: 'Start'),
            ),
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
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => duration = Duration(seconds: duration.inSeconds + 1));
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
    });
  }

  void _currentLaptime() {
    d = duration - d;
    lapList.add(LapItem(lapTime: d, overallTime: duration));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}
