import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/selected_circle_icon.dart';

class TitleAndAlarmTime extends StatelessWidget {
  const TitleAndAlarmTime({
    Key? key,
    required this.isMultiSel,
    required this.isSelected,
    required this.myAlarm,
    required this.isLesser,
  }) : super(key: key);

  final bool isMultiSel;
  final bool isSelected;
  final bool isLesser;
  final MyAlarm myAlarm;

  @override
  Widget build(BuildContext context) {
    final String s = '${myAlarm.date.hour}:';
    final _isLesser = myAlarm.date.minute < 10;
    return Row(
      children: [
        // if selected then Selected_IconMark
        SelectedCirleIcon(isMultiSel: isMultiSel, isSelected: isSelected),
        SizedBox(width: isMultiSel ? 10 : 0),
        // title & time
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(myAlarm.title, maxLines: 2),
            const SizedBox(height: 8),
            Text(
              _isLesser
                  ? s + '0${myAlarm.date.minute}'
                  : s + myAlarm.date.minute.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}
