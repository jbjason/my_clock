import 'package:flutter/material.dart';
import 'package:my_clock/widgets/progress_indicator/build_time.dart';

class BuildStopWatch extends StatelessWidget {
  const BuildStopWatch(
      {Key? key,
      required this.duration,
      required this.val})
      : super(key: key);
  final Duration duration;
  final double val;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 350,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            // Always takes fruction values like .1 .2 .3 .4 .5
            // value: _setSecond(duration),
            value: val,
            valueColor: const AlwaysStoppedAnimation(Color(0xFFB3E5FC)),
            strokeWidth: 12,
            backgroundColor: Colors.lightBlue[50],
          ),
          // Current time ,situated inside of the ProgressIndicator
          Center(child: BuildTime(duration: duration)),
        ],
      ),
    );
  }

  // // getting values for ProgressIndicator(value:)
  // double _setSecond(Duration dur) {
  //   // CircularProgressIndicator(value:) takes only fruction values ..
  //   // here getting part value(double) of totalTime .ex. totalTIme=120 ,
  //   //  totalTime.isSeconds(120) / _currentSecond ==1 this giving 0 part of 120
  //   //  totalTime.isSeconds(119) / _currentSecond ==0.992  this giving 1 part of 120
  //   //  totalTime.isSeconds(118) / _currentSecond ==0.983 this giving 2 part of 120
  //   // for 119 = 0.992 returning 0.992   for 118 = 0.983 , returning 0.983
  //   // here 0 is the destination ,1 is starting *(anti clockWise process).
  //   // this process giving anti clockWise ProgressIndicatior value ..
  //   double _currentSecond = dur.inSeconds / totalTime; // totalTime = initialTimeDuration.inseconds
  //   // if we want clockwise ProgressIndicatior value then statement should be
  //   // double _currentSecond =  (dur.inSeconds / _totalTime); return 1- currentSecond
  //   // this will provide
  //   //for 120, (1- (120/120) )== 0  , for 119, ( 1-(119/120) )=>(0.992-1)=>0.008
  //   //for 118, (1- (118/120) )=>(1-0.983)=> 0.017  , for 117, (1-(117/120))=>(1-0.975)=>0.025
  //   // 1 is the destination for clockWise process
  //   return _currentSecond;
  // }
}