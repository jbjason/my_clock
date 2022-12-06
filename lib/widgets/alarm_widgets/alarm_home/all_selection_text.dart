import 'package:flutter/material.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/selected_circle_icon.dart';

class AllSelectionText extends StatelessWidget {
  const AllSelectionText(
      {Key? key,
      required this.onTap,
      required this.isMultiSelect,
      required this.isAllSelected})
      : super(key: key);
  final void Function() onTap;
  final bool isMultiSelect;
  final bool isAllSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        height: 30,
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          children: [
            SelectedCirleIcon(
                isMultiSel: isMultiSelect, isSelected: isAllSelected),
            const SizedBox(width: 15),
            const Text('All', style: TextStyle(fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
