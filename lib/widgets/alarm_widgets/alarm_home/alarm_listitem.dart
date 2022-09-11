import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/selected_circle_icon.dart';

class AlarmListItem extends StatelessWidget {
  AlarmListItem({
    Key? key,
    required this.myAlarm,
    required this.enabledMultiSel,
    required this.isSelected,
    required this.addToSelectedItem,
    required this.isMultiSel,
  }) : super(key: key);
  final MyAlarm myAlarm;
  final VoidCallback enabledMultiSel;
  final ValueChanged<MyAlarm> addToSelectedItem;
  final bool isSelected, isMultiSel;
  final _isOn = ValueNotifier<bool>(false);

  final List<String> _daysList = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    bool _isLesser = false;
    return InkWell(
      onLongPress: () {
        enabledMultiSel();
        addToSelectedItem(myAlarm);
      },
      onTap: () => addToSelectedItem(myAlarm),
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title ,AlarmTime , Selected IconMark
              Flexible(flex: 4, child: _titleAndAlarmTime(_isLesser)),
              // Selected WeekDays & Switcher
              Flexible(flex: 4, child: _selectedWeekDaysAndSwitcher()),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500]!,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 5.0),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ],
            gradient: isSelected
                ? LinearGradient(colors: [Colors.grey[500]!, Colors.grey[600]!])
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFEBF3FE),
                      Colors.grey[200]!,
                      Colors.grey[300]!,
                      Colors.grey[400]!,
                    ],
                    stops: const [0.1, 0.4, 0.7, 1],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _selectedWeekDaysAndSwitcher() {
    int i = 0, _length = myAlarm.weekDays.length;
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _daysList.length,
            itemBuilder: (context, index) {
              bool isSelected = false;
              // if index matches then i++ till i <length
              if (i < _length && myAlarm.weekDays[i] == index) {
                isSelected = true;
                i++;
              }
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isSelected
                        ? Text(
                            '•',
                            style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontWeight: FontWeight.w900),
                          )
                        : const Text(''),
                    Text(
                      _daysList[index],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w300,
                          color: Colors.blueGrey[900]),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // switch icon
        ValueListenableBuilder(
          valueListenable: _isOn,
          builder: (context, bool isOn, _) => CupertinoSwitch(
            value: isOn,
            activeColor: Colors.blueGrey[400],
            trackColor: Colors.blueGrey[200],
            onChanged: (val) => isOn = !isOn,
          ),
        ),
      ],
    );
  }

  Widget _titleAndAlarmTime(bool isLesser) {
    final String s = '${myAlarm.date.hour}:';
    isLesser = myAlarm.date.minute < 10;
    return Row(
      children: [
        // if selected then Selected_IconMark
        SelectedCirleIcon(isMultiSel: isMultiSel, isSelected: isSelected),
        SizedBox(width: isMultiSel ? 10 : 0),
        // title & time
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(myAlarm.title),
            const SizedBox(height: 8),
            Text(
              isLesser
                  ? s + '0${myAlarm.date.minute}'
                  : s + myAlarm.date.minute.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}
