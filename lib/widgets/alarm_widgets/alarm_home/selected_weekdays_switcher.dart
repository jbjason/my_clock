import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';

class SelectedWeekdaysSwitcher extends StatelessWidget {
  const SelectedWeekdaysSwitcher({Key? key, required this.myAlarm})
      : super(key: key);
  final MyAlarm myAlarm;
  @override
  Widget build(BuildContext context) {
    final List<String> _daysList = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    int i = 0, _length = myAlarm.weekDays.length;
    final _isOn = ValueNotifier<bool>(false);
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
}
