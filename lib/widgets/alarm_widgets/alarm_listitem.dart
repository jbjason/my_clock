import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';

class AlarmListItem extends StatefulWidget {
  const AlarmListItem({
    Key? key,
    required this.myAlarm,
  }) : super(key: key);
  final MyAlarm myAlarm;
  @override
  State<AlarmListItem> createState() => _AlarmListItemState();
}

class _AlarmListItemState extends State<AlarmListItem> {
  bool _isOn = false;
  late bool _isLesser;
  final List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  @override
  void initState() {
    super.initState();
    _isLesser = widget.myAlarm.date.minute < 10;
  }

  @override
  Widget build(BuildContext context) {
    final String s = '${widget.myAlarm.date.hour}:';
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Column(
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
              ),
            ),
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weekDays.length,
                      itemBuilder: (context, index) {
                        final bool _isSelected =
                            widget.myAlarm.weekDays[index] == index;
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isSelected
                                  ? Text(
                                      '•',
                                      style: TextStyle(
                                          color: Colors.blueGrey[900],
                                          fontWeight: FontWeight.w900),
                                    )
                                  : const Text(''),
                              Text(
                                weekDays[index],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: _isSelected
                                        ? FontWeight.w500
                                        : FontWeight.w300,
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
              ),
            ),
          ],
        ),
        decoration: decoration,
      ),
    );
  }

  final decoration = BoxDecoration(
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
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.grey[200]!,
        Colors.grey[400]!,
        Colors.blue[300]!.withOpacity(0.5),
      ],
      stops: const [0.0, 0.6, 1],
    ),
  );
}
