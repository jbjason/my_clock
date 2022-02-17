import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_clock/models/create_notification.dart';
import 'package:my_clock/widgets/alarm_widgets/hour_minutes_text.dart';
import 'package:my_clock/widgets/alarm_widgets/title_textField.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/item_container.dart';
import 'package:my_clock/widgets/timer_widgets/white_button.dart';

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
  late DateTime selectedDateTIme;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: h);
    _minuteController = FixedExtentScrollController(initialItem: m);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                            _listWheelScroll(size, _hourController, 23, 'h'),
                            const Text(':',),
                            _listWheelScroll(size, _minuteController, 59, 'm'),
                          ],
                        ),
                      ),
                    ),
                    // Tilte textField & time selection area
                    Positioned(
                      left: 0,
                      right: 0,
                      top: size.height * .5 + 10,
                      child: Container(
                        height: size.height * .47,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today : $currentDate',
                                    style: TextStyle(color: Colors.grey[900]),
                                  ),
                                  IconButton(
                                      icon: Icon(CupertinoIcons.calendar,
                                          size: 30, color: Colors.grey[900]),
                                      onPressed: () {})
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
                                  onTap: () => _selectedDay = index + 1,
                                  child: WeekDaysList(
                                      index: index,
                                      weekDays: weekDays,
                                      selectedDay: _selectedDay),
                                ),
                              ),
                            ),
                            // title textField
                            TitleTextFormField(
                                titleController: _titleController),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: const WhiteButton(text: 'Cancel'),
                                  onTap: () {},
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
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            _selectedDay,
                                            h,
                                            m,
                                            s,
                                            0, //milisec
                                          ),
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
            return ItemContainer(
                i: index, selectedText: text, h: h, m: m, s: s);
          },
        ),
      ),
    );
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
                _selectedDay == index ?FontWeight.w900: FontWeight.w400 ,
            color: _selectedDay == index ? Colors.grey[900] : Colors.grey[700],
          )),
    );
  }
}
