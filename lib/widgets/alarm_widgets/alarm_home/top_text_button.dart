import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/add_alarm/add_alarm_widget.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/cancel_and_delete_icon.dart';

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
        child: isMultiSel
            ? CancelAndDeleteIcon(
                cancelMultiSel: cancelMultiSel,
                mulSelectedItems: mulSelectedItems,
              )
            : Row(
                // if multiSelect isn't selected
                children: [
                  const Text(
                    'Alarm',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF616161),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(CupertinoIcons.add, size: 25),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const AddAlarmWidget()),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
