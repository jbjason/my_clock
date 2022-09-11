import 'package:flutter/material.dart';
import 'package:my_clock/models/lap_item.dart';

class LapTimeTitleAll extends StatelessWidget {
  const LapTimeTitleAll({
    Key? key,
    required this.size,
    required this.lapList,
  }) : super(key: key);

  final Size size;
  final List<LapItem> lapList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: size.height * .2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Lap', style: TextStyle(fontWeight: FontWeight.w400)),
              Text('Lap Time', style: TextStyle(fontWeight: FontWeight.w400)),
              Text('Overall Time',
                  style: TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child:
                  Divider(color: Colors.grey.withOpacity(0.5), thickness: 1.5)),
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
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
