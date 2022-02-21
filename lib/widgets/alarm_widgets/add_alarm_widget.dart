import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_clock/models/create_notification.dart';
import 'package:my_clock/widgets/alarm_widgets/hour_minutes_text.dart';
import 'package:my_clock/widgets/alarm_widgets/title_textField.dart';
import 'package:my_clock/widgets/alarm_widgets/weekdays_list.dart';
import 'package:my_clock/widgets/common_widgets/wheel_item.dart';
import 'package:my_clock/widgets/common_widgets/white_button.dart';

class AddAlarmWidget extends StatefulWidget {
  const AddAlarmWidget({Key? key}) : super(key: key);
  @override
  _AddAlarmWidgetState createState() => _AddAlarmWidgetState();
}

class _AddAlarmWidgetState extends State<AddAlarmWidget> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  final _titleController = TextEditingController();
  final String currentDate = DateFormat('EEEE, d MMM').format(DateTime.now());
  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  int h = DateTime.now().hour, m = DateTime.now().minute, s = 0;
  int _selectedDay = DateTime.now().weekday;
  DateTime selectedDateTIme = DateTime.now();

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: h);
    _minuteController = FixedExtentScrollController(initialItem: m);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  // only Hour Minute Top Text
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 40,
                    child: HourMinutesText(),
                  ),
                  // ListWheel
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: size.height * .55,
                      // width: size.width,
                      padding: EdgeInsets.only(
                          bottom: size.height * .05, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _listWheelScroll(size, _hourController, 24, 'h'),
                          const Text(
                            ':',
                          ),
                          _listWheelScroll(size, _minuteController, 60, 'm'),
                        ],
                      ),
                    ),
                  ),
                  // Tilte textField & time selection area
                  Positioned(
                    left: 0,
                    right: 0,
                    top: size.height * .5,
                    child: Container(
                      height: size.height * .45,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.grey[350],
                      ),
                      child: Column(
                        children: [
                          // todays Date & Calender
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Today : $currentDate',
                                  style: TextStyle(color: Colors.grey[900]),
                                ),
                                IconButton(
                                  icon: Icon(CupertinoIcons.calendar,
                                      size: 30, color: Colors.grey[900]),
                                  onPressed: () => _chooseDate(context),
                                ),
                              ],
                            ),
                          ),
                          // Select weekDays
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weekDays.length,
                              itemBuilder: (context, index) => InkWell(
                                // +1 cz as default Monday=1 ,Tu=2, 'We'=3, 'Th'=4, 'Fr'=5, 'Sa'=6, 'Su'=7
                                onTap: () =>
                                    setState(() => _selectedDay = index + 1),
                                child: WeekDaysList(
                                    index: index,
                                    weekDays: weekDays,
                                    selectedDay: _selectedDay),
                              ),
                            ),
                          ),
                          // title textField
                          TitleTextFormField(titleController: _titleController),
                          const SizedBox(height: 40),
                          // cancel & save button
                          Row(
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
                                  final titleText =
                                      _titleController.text.trim();
                                  if (titleText.isNotEmpty) {
                                    final int id = createUniqueId();
                                    await createScheduleNotification(
                                      id,
                                      titleText,
                                      NotificationWeekAndTime(
                                        dayOfTheWeek: _selectedDay,
                                        dateTime: DateTime(
                                          selectedDateTIme.year,
                                          selectedDateTIme.month,
                                          selectedDateTIme.day,
                                          h,
                                          m,
                                          s,
                                          0, //milisec
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Alarm Has been Created'),
                                        ),
                                      );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listWheelScroll(Size size, FixedExtentScrollController controller,
      int childCount, String text) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .17,
        perspective: 0.008,
        diameterRatio: 1.8,
        useMagnifier: true,
        magnification: 1.1,
        onSelectedItemChanged: (value) {
          setState(() => text == 'm' ? m = value : h = value);
        },
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return WheelItem(i: index, selectedText: text, h: h, m: m, s: s);
          },
        ),
      ),
    );
  }

  void _chooseDate(BuildContext context) async {
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
        setState(() => selectedDateTIme = newDateTime);
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

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: const StadiumBorder(),
    content: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(colors: [
          Colors.grey[800]!,
          Colors.grey,
          Colors.grey[300]!,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
