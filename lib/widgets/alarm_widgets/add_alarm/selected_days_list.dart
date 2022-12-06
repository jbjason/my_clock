import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDaysList extends StatelessWidget {
  const SelectedDaysList({
    Key? key,
    required this.isCalSelected,
    required this.selectedDateTime,
    required this.selectedWeekDays,
    required this.weekDays,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;
  final bool isCalSelected;
  final DateTime selectedDateTime;
  final List<int> selectedWeekDays;
  final List<String> weekDays;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: width,
      child: Center(
        child: Row(
          children: [
            Text(
              'Selected: ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]!),
            ),
            isCalSelected
                ? Text(DateFormat(' EEEE, MMM d').format(selectedDateTime))
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedWeekDays.length,
                      itemBuilder: (context, index) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            weekDays[selectedWeekDays[index]].toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
