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
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
          color: _selectedDay - 1 == index ? Colors.grey : Colors.transparent,
          shape:
              _selectedDay - 1 == index ? BoxShape.circle : BoxShape.rectangle),
      child: Center(
        child: Text(weekDays[index],
            style: TextStyle(
              fontWeight:
                  _selectedDay - 1 == index ? FontWeight.w900 : FontWeight.w400,
              color:
                  _selectedDay - 1 == index ? Colors.grey[900] : Colors.grey[700],
            )),
      ),
    );
  }
}
