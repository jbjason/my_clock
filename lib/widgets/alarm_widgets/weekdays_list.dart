import 'package:flutter/material.dart';

class WeekDaysList extends StatelessWidget {
  const WeekDaysList({
    Key? key,
    required this.index,
    required this.weekDays,
    required int selectedDay,
  })  : _selectedDay = selectedDay,
        super(key: key);

  final List<String> weekDays;
  final int _selectedDay, index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17),
      child: Text(weekDays[index],
          style: TextStyle(
            fontWeight:
                _selectedDay - 1 == index ? FontWeight.w900 : FontWeight.w400,
            color:
                _selectedDay - 1 == index ? Colors.grey[900] : Colors.grey[700],
          )),
    );
  }
}
