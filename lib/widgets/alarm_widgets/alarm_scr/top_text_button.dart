import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/add_alarm_widget.dart';
import 'package:provider/provider.dart';

class TopTextAndAddAlarmButton extends StatelessWidget {
  const TopTextAndAddAlarmButton({
    Key? key,
    required this.isMultiSel,
    required this.cancelMultiSel,
    required this.mulSelectedItems,
  }) : super(key: key);
  final bool isMultiSel;
  final VoidCallback cancelMultiSel;
  final List<MyAlarm> mulSelectedItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 8,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      child: Center(
        child: Row(
          children: [
            const Text(
              'Alarm ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF616161),
              ),
            ),
            const Spacer(),
            isMultiSel
                ? Row(
                    children: [
                      TextButton(
                        onPressed: () => cancelMultiSel(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          Provider.of<MyAlarms>(context, listen: false)
                              .deleteAlarms(mulSelectedItems);
                        },
                        icon: const Icon(Icons.delete,
                            size: 22, color: Colors.red),
                      )
                    ],
                  )
                : IconButton(
                    icon: const Icon(CupertinoIcons.add, size: 25),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const AddAlarmWidget()));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
