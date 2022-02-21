import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_clock/models/lap_item.dart';
import 'package:my_clock/widgets/progress_indicator/build_stop_watch.dart';
import 'package:my_clock/widgets/timer_widgets/white_button.dart';

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

  void _startWatch() {
    toggleButton();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => duration = Duration(seconds: duration.inSeconds + 1));
      }
    });
  }

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
          SizedBox(
            height: size.height * .2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Lap', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Lap Time',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Overall Time',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(color: Colors.grey.withOpacity(0.5), thickness: 1.5),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(i.toString()),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: !_isStopped ? _currentLaptime : _resetWatch,
                child: WhiteButton(text: !_isStopped ? 'LapTime' : 'Reset'),
              ),
              !_isStarted
                  ? InkWell(
                      onTap: _startWatch,
                      child: const WhiteButton(text: 'Start'),
                    )
                  : InkWell(
                      onTap: _isStopped ? _resumeWatch : _stopWatch,
                      child: WhiteButton(text: _isStopped ? 'Resume' : 'Stop'),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _stopWatch() {
    setState(() {
      _isStopped = !_isStopped;
      _currentCountDown = duration;
      timer?.cancel();
    });
  }

  void _resumeWatch() {
    toggleButton();
    setState(() => duration = _currentCountDown);
    _startWatch();
  }

  void _resetWatch() {
    toggleButton();
    setState(() {
      duration = const Duration();
      timer?.cancel();
    });
  }

  void _currentLaptime() {
    d = duration - d;
    lapList.add(LapItem(lapTime: d, overallTime: duration));
  }

  void toggleButton() {
    setState(() {
      _isStarted = !_isStarted;
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
