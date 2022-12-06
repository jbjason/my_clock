import 'package:flutter/material.dart';
import 'package:my_clock/constants/constant.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/selected_weekdays_switcher.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/title_and_alarm_time.dart';

class AlarmListItem extends StatelessWidget {
  const AlarmListItem({
    Key? key,
    required this.myAlarm,
    required this.enabledMultiSel,
    required this.isSelected,
    required this.addToSelectedItem,
    required this.isMultiSel,
  }) : super(key: key);
  final MyAlarm myAlarm;
  final VoidCallback enabledMultiSel;
  final ValueChanged<MyAlarm> addToSelectedItem;
  final bool isSelected, isMultiSel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        enabledMultiSel();
        addToSelectedItem(myAlarm);
      },
      onTap: () => addToSelectedItem(myAlarm),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title ,AlarmTime , Selected IconMark
              Flexible(
                flex: 4,
                child: TitleAndAlarmTime(
                  isMultiSel: isMultiSel,
                  isSelected: isSelected,
                  myAlarm: myAlarm,
                  isLesser: false,
                ),
              ),
              // Selected WeekDays & Switcher
              Flexible(
                flex: 4,
                child: SelectedWeekdaysSwitcher(myAlarm: myAlarm),
              ),
            ],
          ),
          decoration: alarmListDecoration(isSelected),
        ),
      ),
    );
  }
}
