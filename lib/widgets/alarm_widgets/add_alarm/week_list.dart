import 'package:flutter/material.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/weekdays_list.dart';

class WeekList extends StatelessWidget {
  const WeekList(
      {Key? key,
      required this.selectedDay,
      required this.weekDays,
      required this.onTap})
      : super(key: key);
  final void Function(int index) onTap;
  final List<String> weekDays;
  final int selectedDay;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDays.length,
        itemBuilder: (context, index) => InkWell(
          // +1 cz as default Monday=1 ,Tu=2, 'We'=3, 'Th'=4, 'Fr'=5, 'Sa'=6, 'Su'=7
          onTap: () => onTap(index),
          child: WeekDaysList(
            index: index,
            weekDays: weekDays,
            selectedDay: selectedDay,
          ),
        ),
      ),
    );
  }
}
