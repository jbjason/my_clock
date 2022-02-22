import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm_widget.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_listitem.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _myAlarms = Provider.of<MyAlarms>(context).items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TopTextAndAddAlarmButton(),
        Expanded(
          child: ListView.builder(
            itemCount: _myAlarms.length,
            itemBuilder: (context, index) => AlarmListItem(
              myAlarm: _myAlarms[index],
            ),
          ),
        ),
      ],
    );
  }
}

class TopTextAndAddAlarmButton extends StatelessWidget {
  const TopTextAndAddAlarmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 30,
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Alarm ',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF616161)),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(CupertinoIcons.add, size: 22),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddAlarmWidget()));
            },
          ),
        ],
      ),
    );
  }
}
