import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/cancel_save_button.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/hour_minutes_text.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/selected_days_list.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/title_textfield.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/todays_date_calender.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/week_list.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/wheel_list.dart';

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
                            CancelSaveButton(
                              titleController: _titleController,
                              selectedDateTime: _selectedDateTime,
                              h: h,
                              m: m,
                              isCalSelected: _isCalSelected,
                              selectedWeekDays: _selectedWeekDays,
                              selectedDay: _selectedDay,
                            ),
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

  Widget _wheelList(Size size) {
    return WheelList(
      hourController: _hourController,
      minuteController: _minuteController,
      h: h,
      m: m,
      s: s,
      onSelectedItemChanged: (value, text) {
        text == 'm' ? m = value : h = value;
        setState(() {});
      },
    );
  }

  Widget _todaysDateAndCalender() {
    return TodaysDateCalender(
      currentDate: currentDate,
      selectDate: (DateTime newDateTime) {
        _selectedDateTime = newDateTime;
        _isCalSelected = true;
        setState(() {});
      },
    );
  }

  Widget _weekList() {
    return WeekList(
      selectedDay: _selectedDay,
      weekDays: weekDays,
      onTap: (int index) {
        _selectedDay = index + 1;
        if (!_selectedWeekDays.contains(index)) {
          _selectedWeekDays.add(index);
        }
        setState(() {});
      },
    );
  }

  Widget _selectedDaysList(Size size) {
    return SelectedDaysList(
      isCalSelected: _isCalSelected,
      selectedDateTime: _selectedDateTime,
      selectedWeekDays: _selectedWeekDays,
      weekDays: weekDays,
      onTap: () {
        if (_isCalSelected) {
          _isCalSelected = false;
          _selectedDateTime = DateTime.now();
          _selectedWeekDays = [];
          _selectedWeekDays.add(_selectedDay - 1);
          setState(() {});
        } else {
          _selectedWeekDays = [];
          _selectedWeekDays.add(_selectedDay - 1);
          setState(() {});
        }
      },
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
        const Color(0xFFEBF3FE),
        Colors.grey[200]!,
        Colors.grey[300]!,
        Colors.grey[400]!,
      ],
      stops: const [0.1, 0.4, 0.5, 1],
    ),
  );
}
