import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';

class AlarmListItem extends StatefulWidget {
  const AlarmListItem({
    Key? key,
    required this.myAlarm,
    required this.enabledMultiSel,
    required this.isSelected,
    required this.addToSelectedItem,
  }) : super(key: key);
  final MyAlarm myAlarm;
  final VoidCallback enabledMultiSel;
  final ValueChanged<MyAlarm> addToSelectedItem;
  final bool isSelected;

  @override
  State<AlarmListItem> createState() => _AlarmListItemState();
}

class _AlarmListItemState extends State<AlarmListItem> {
  bool _isOn = false;
  late bool _isLesser;
  final List<String> _daysList = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        widget.enabledMultiSel();
        widget.addToSelectedItem(widget.myAlarm);
      },
      onTap: () => widget.addToSelectedItem(widget.myAlarm),
      child: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17,bottom: 17),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 4, child: _titleAndAlarmTime()),
              Flexible(
                flex: 4,
                child: _selectedWeekDaysAndSwitcher(),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
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
            gradient: widget.isSelected
                ? LinearGradient(colors: [Colors.grey[500]!, Colors.grey[600]!])
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[200]!,
                      Colors.grey[400]!,
                      Colors.blue[300]!.withOpacity(0.5),
                    ],
                    stops: const [0.0, 0.55, 1],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _selectedWeekDaysAndSwitcher() {
    int i = 0, _length = widget.myAlarm.weekDays.length;
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _daysList.length,
            itemBuilder: (context, index) {
              bool isSelected = false;
              // if index matches then i++ till i <length
              if (i < _length && widget.myAlarm.weekDays[i] == index) {
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
        CupertinoSwitch(
          value: _isOn,
          activeColor: Colors.blueGrey[400],
          trackColor: Colors.blueGrey[200],
          onChanged: (val) => setState(() => _isOn = !_isOn),
        ),
      ],
    );
  }

  Widget _titleAndAlarmTime() {
    final String s = '${widget.myAlarm.date.hour}:';
    _isLesser = widget.myAlarm.date.minute < 10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.myAlarm.title),
        const SizedBox(height: 8),
        Text(
          _isLesser
              ? s + '0${widget.myAlarm.date.minute}'
              : s + widget.myAlarm.date.minute.toString(),
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
