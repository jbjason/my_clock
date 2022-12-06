import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class TodaysDateCalender extends StatelessWidget {
  const TodaysDateCalender({
    Key? key,
    required this.selectDate,
    required this.currentDate,
  }) : super(key: key);

  final Function(DateTime newDateTime) selectDate;
  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Today : $currentDate',
            style:
                TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: Icon(CupertinoIcons.calendar,
                size: 30, color: Colors.grey[900]),
            onPressed: () => chooseDate(context),
          ),
        ],
      ),
    );
  }

  void chooseDate(BuildContext context) async {
    final date = DateTime.now();
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      height: 340,
      borderRadius: 35,
      initialDate: date,
      firstDate: DateTime(date.year),
      lastDate: DateTime(date.year + 1),
      theme: ThemeData.dark(),
      imageHeader: const AssetImage('assets/3.jpg'),
      description: 'Chose your prefered date ..',
    );
    if (newDateTime != null) {
      final monthDays = newDateTime.subtract(const Duration(days: 1));

      if (newDateTime.year > date.year ||
          newDateTime.month > date.month ||
          newDateTime.month == date.month && monthDays.day >= date.day - 1) {
        selectDate;
      } else {
        showDialog(
          context: context,
          builder: (c) => CupertinoAlertDialog(
            title: const Text(
                "This date cannot be selected. This Day passed already !"),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
    }
  }
}
