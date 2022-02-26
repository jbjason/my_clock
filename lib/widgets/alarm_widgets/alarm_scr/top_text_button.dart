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
        child: isMultiSel
            ? cancelAndDeleteIcon(context)
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

  Widget cancelAndDeleteIcon(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => cancelMultiSel(),
          child: const Icon(Icons.close, size: 22),
        ),
        const SizedBox(width: 14),
        Text(
          '${mulSelectedItems.length} items selected.',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF616161),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (c) => CupertinoAlertDialog(
                title: const Text("Are you sure wanna delete these alarms ?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text("OK"),
                    onPressed: () {
                      Provider.of<MyAlarms>(context, listen: false)
                          .deleteAlarms(mulSelectedItems);
                      cancelMultiSel();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.delete, size: 22, color: Colors.red),
        )
      ],
    );
  }
}
