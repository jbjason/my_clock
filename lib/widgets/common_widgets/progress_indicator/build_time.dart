import 'package:flutter/material.dart';
import 'package:my_clock/widgets/common_widgets/progress_indicator/build_time_card.dart';

class BuildTime extends StatelessWidget {
  const BuildTime({Key? key, required this.duration}) : super(key: key);
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // buildTime()'s outside structure
        BuildTimeCard(time: hours, header: 'Hour'),
        const SizedBox(width: 10),
        BuildTimeCard(time: minutes, header: 'Minute'),
        const SizedBox(width: 10),
        BuildTimeCard(time: seconds, header: 'Second'),
      ],
    );
  }
}