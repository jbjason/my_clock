import 'package:flutter/material.dart';
import 'package:my_clock/constants/constant.dart';
import 'package:my_clock/models/clock.dart';

class InternationalTimes extends StatelessWidget {
  const InternationalTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, i) =>
          _getInternationalTime(countries[i].title, countries[i].hourStatus),
    );
  }

  Widget _getInternationalTime(String country, int _hourBehind) {
    final _time = DateTime.now();
    final _timeNow = '${(_time.hour + _hourBehind) % 24} : ${_time.minute}';
    final _hourText = _hourBehind < 0 ? -_hourBehind : _hourBehind;
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: alarmListDecoration(false),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                country,
                style: const TextStyle(fontSize: 25),
              ),
              Text('$_hourText hours behind',
                  style: const TextStyle(fontSize: 11)),
            ],
          ),
          Text(_timeNow, style: const TextStyle(fontSize: 25))
        ],
      ),
    );
  }
}
