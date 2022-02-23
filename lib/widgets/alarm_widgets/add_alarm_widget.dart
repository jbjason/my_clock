import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_clock/models/create_notification.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/hour_minutes_text.dart';
import 'package:my_clock/widgets/alarm_widgets/title_textField.dart';
import 'package:my_clock/widgets/alarm_widgets/weekdays_list.dart';
import 'package:my_clock/widgets/common_widgets/wheel_item.dart';
import 'package:my_clock/widgets/common_widgets/white_button.dart';
import 'package:provider/provider.dart';

class AddAlarmWidget extends StatefulWidget {
  const AddAlarmWidget({Key? key}) : super(key: key);
  @override
  _AddAlarmWidgetState createState() => _AddAlarmWidgetState();
}

class _AddAlarmWidgetState extends State<AddAlarmWidget> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  final _titleController = TextEditingController();
  String currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());
  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  // DateTime.now().weekday  gives from 1 to 7 not 0 to 7
  List<int> _selectedWeekDays = [DateTime.now().weekday - 1];
  DateTime _selectedDateTime = DateTime.now();
  int _selectedDay = DateTime.now().weekday;
  int h = DateTime.now().hour, m = DateTime.now().minute, s = 0;
  bool _isCalSelected = false;

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
                    height: 60,
                    child: HourMinutesText(),
                  ),
                  // ListWheel
                  Positioned(
                      top: 30, left: 0, right: 0, child: _wheelList(size)),
                  // Tilte textField & time selection area
                  Positioned(
                    left: 0,
                    right: 0,
                    top: size.height * .5 - 10,
                    child: Container(
                      height: size.height * .55,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // todays Date & Calender
                            _todaysDateAndCalender(),
                            // Select weekDays
                            _isCalSelected ? Container() : _weekList(),
                            // Selected days List
                            _selectedDaysList(size),
                            // title textField
                            TitleTextFormField(
                                titleController: _titleController),
                            const SizedBox(height: 40),
                            // cancel & save button
                            _cancelAndSaveButton(),
                          ],
                        ),
                      ),
                      decoration: decoration,
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

  Widget _todaysDateAndCalender() {
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
            onPressed: () => _chooseDate(context),
          ),
        ],
      ),
    );
  }

  Widget _wheelList(Size size) {
    return Container(
      height: size.height * .52,
      // width: size.width,
      padding: EdgeInsets.only(bottom: size.height * .05, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _listWheelScroll(size, _hourController, 24, 'h'),
          Text(':', style: TextStyle(height: 30, color: Colors.grey[600])),
          _listWheelScroll(size, _minuteController, 60, 'm'),
        ],
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

  Widget _weekList() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekDays.length,
        itemBuilder: (context, index) => InkWell(
          // +1 cz as default Monday=1 ,Tu=2, 'We'=3, 'Th'=4, 'Fr'=5, 'Sa'=6, 'Su'=7
          onTap: () => setState(() {
            _selectedDay = index + 1;
            if (!_selectedWeekDays.contains(index)) {
              _selectedWeekDays.add(index);
            }
          }),
          child: WeekDaysList(
              index: index, weekDays: weekDays, selectedDay: _selectedDay),
        ),
      ),
    );
  }

  Widget _selectedDaysList(Size size) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: size.width,
      child: Center(
        child: Row(
          children: [
            Text(
              'Selected: ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]!),
            ),
            _isCalSelected
                ? Text(DateFormat(' EEEE, MMM d').format(_selectedDateTime))
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedWeekDays.length,
                      itemBuilder: (context, index) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            weekDays[_selectedWeekDays[index]].toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
            IconButton(
              onPressed: () {
                if (_isCalSelected) {
                  setState(() {
                    _isCalSelected = false;
                    _selectedDateTime = DateTime.now();
                    _selectedWeekDays = [];
                    _selectedWeekDays.add(_selectedDay - 1);
                  });
                } else {
                  setState(() {
                    _selectedWeekDays = [];
                    _selectedWeekDays.add(_selectedDay - 1);
                  });
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ],
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
        setState(() {
          _selectedDateTime = newDateTime;
          _isCalSelected = true;
        });
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

  Widget _cancelAndSaveButton() {
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
            final titleText = _titleController.text.trim();
            if (titleText.isNotEmpty) {
              final int id = createUniqueId();
              final _dtime = DateTime(_selectedDateTime.year,
                  _selectedDateTime.month, _selectedDateTime.day, h, m);
              await createScheduleNotification(
                id,
                titleText,
                _isCalSelected,
                NotificationWeekAndTime(
                    dayOfTheWeek: _selectedDay, dateTime: _dtime),
              );
              _selectedWeekDays.sort();
              Provider.of<MyAlarms>(context, listen: false).addAlarm(MyAlarm(
                id: id.toString(),
                title: titleText,
                weekDays: _selectedWeekDays,
                date: _dtime,
                isCalSelected: _isCalSelected,
              ));
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Alarm Has been Created'),
                  ),
                );
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
        ),
      ],
    );
  }

  final decoration = BoxDecoration(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50),
    ),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue[300]!.withOpacity(0.5),
        Colors.grey[400]!,
        Colors.grey[300]!,
      ],
      stops: const [0.0, 0.5, 1],
    ),
  );
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
