import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedCirleIcon extends StatelessWidget {
  const SelectedCirleIcon({
    Key? key,
    required this.isMultiSel,
    required this.isSelected,
  }) : super(key: key);

  final bool isMultiSel, isSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isMultiSel ? 27 : 0,
        width: isMultiSel ? 27 : 0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEBF3FE), width: 2),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey[600]!, width: 2),
          ),
          child: isSelected
              ? const Icon(CupertinoIcons.check_mark, size: 18)
              : const SizedBox(),
        ),
      ),
    );
  }
}
