import 'package:flutter/material.dart';
import 'package:my_clock/models/create_notification.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/common_widgets/white_button.dart';
import 'package:provider/provider.dart';

class CancelSaveButton extends StatelessWidget {
  const CancelSaveButton({
    Key? key,
    required this.titleController,
    required this.selectedDateTime,
    required this.h,
    required this.m,
    required this.isCalSelected,
    required this.selectedWeekDays,
    required this.selectedDay,
  }) : super(key: key);

  final TextEditingController titleController;
  final DateTime selectedDateTime;
  final int h;
  final int m;
  final bool isCalSelected;
  final List<int> selectedWeekDays;
  final int selectedDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: const WhiteButton(text: 'Cancel'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: const WhiteButton(text: 'Save'),
          onTap: () async {
            final titleText = titleController.text.trim();
            if (titleText.isNotEmpty) {
              final int id = createUniqueId();
              final _dtime = DateTime(selectedDateTime.year,
                  selectedDateTime.month, selectedDateTime.day, h, m);
              await createScheduleNotification(
                id,
                titleText,
                isCalSelected,
                selectedWeekDays,
                NotificationWeekAndTime(
                  dayOfTheWeek: selectedDay,
                  dateTime: _dtime,
                ),
              );
              selectedWeekDays.sort();
              Provider.of<MyAlarms>(context, listen: false).addAlarm(MyAlarm(
                id: id.toString(),
                title: titleText,
                weekDays: selectedWeekDays,
                date: _dtime,
                isCalSelected: isCalSelected,
              ));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(
                        'Alarm set for ${(DateTime.now().hour - _dtime.hour).abs()} hour ${(DateTime.now().minute - _dtime.minute).abs()} minutes from now.'),
                  ),
                );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(_getSnackBar());
            }
          },
        ),
      ],
    );
  }

  SnackBar _getSnackBar() => SnackBar(
        backgroundColor: Colors.grey[300],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
        content: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.grey[400]!,
                Colors.grey[350]!,
                Colors.grey[300]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Text(
            'Title text can\'t be Empty..!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
}
