import 'dart:async';
import 'package:flutter/material.dart';

class TimerClock extends StatefulWidget {
  const TimerClock({Key? key, required this.initDuration}) : super(key: key);
  final Duration initDuration;
  @override
  _TimerClockState createState() => _TimerClockState();
}

class _TimerClockState extends State<TimerClock> {
  late Duration duration;
  double _totalTime = 0;
  var _currentCountDown = const Duration(minutes: 0);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    duration = widget.initDuration;
    _totalTime = duration.inSeconds.toDouble();
  }

  void _startWatchh() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds != 0) {
        setState(() => duration = Duration(seconds: duration.inSeconds - 1));
      } else {
        timer!.cancel();
      }
    });
  }

  void _stopWatchh() {
    setState(() {
      _currentCountDown = duration;
      timer?.cancel();
    });
  }

  void _resumeWatchh() {
    setState(() => duration = _currentCountDown);
    _startWatchh();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: buildStopWatch(duration),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
            onPressed: () => _startWatchh(), child: const Text('Start')),
        ElevatedButton(
            onPressed: () => _stopWatchh(), child: const Text('Stop')),
        ElevatedButton(
            onPressed: () => _resumeWatchh(), child: const Text('Resume')),
      ],
    ));
  }

  Widget buildStopWatch(Duration dur) => SizedBox(
        width: 350,
        height: 350,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              // Always takes fruction values like .1 .2 .3 .4 .5
              value: _setSecond(dur),
              valueColor: const AlwaysStoppedAnimation(Colors.grey),
              strokeWidth: 12,
              backgroundColor: Colors.grey[300],
            ),
            Center(child: buildTime()),
          ],
        ),
      );
  // getting values for ProgressIndicator(value:)
  double _setSecond(Duration dur) {
    // CircularProgressIndicator(value:) takes only fruction values ..
    // here getting part value(double) of totalTime .ex. totalTIme=120 ,
    //  totalTime.isSeconds(120) / _currentSecond ==1 this giving 0 part of 120
    //  totalTime.isSeconds(119) / _currentSecond ==0.992  this giving 1 part of 120
    //  totalTime.isSeconds(118) / _currentSecond ==0.983 this giving 2 part of 120
    // for 119 = 0.992 returning 0.992   for 118 = 0.983 , returning 0.983
    // here 0 is the destination ,1 is starting *(anti clockWise process).
    // this process giving anti clockWise ProgressIndicatior value ..
    double _currentSecond = dur.inSeconds / _totalTime;
    // if we want clockwise ProgressIndicatior value then statement should be
    // double _currentSecond =  (dur.inSeconds / _totalTime); return 1- currentSecond
    // this will provide
    //for 120, (1- (120/120) )== 0  , for 119, ( 1-(119/120) )=>(0.992-1)=>0.008
    //for 118, (1- (118/120) )=>(1-0.983)=> 0.017  , for 117, (1-(117/120))=>(1-0.975)=>0.025
    // 1 is the destination for clockWise process
    return _currentSecond;
  }
  // Current time ,situated inside of the ProgressIndicator 
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'Hour'),
        const SizedBox(width: 10),
        buildTimeCard(time: minutes, header: 'Minute'),
        const SizedBox(width: 10),
        buildTimeCard(time: seconds, header: 'Second'),
      ],
    );
  }
  // buildTime()'s outside structure
  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
        ),
        const SizedBox(height: 15),
        Text(header),
      ],
    );
  }
}
