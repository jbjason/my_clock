import 'package:flutter/material.dart';

class MinuteAddTenMore extends StatelessWidget {
  const MinuteAddTenMore({
    Key? key,
    required FixedExtentScrollController minuteController,
  })  : _minuteController = minuteController,
        super(key: key);

  final FixedExtentScrollController _minuteController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[700]!, width: 2),
      ),
      child: TextButton(
        child: const Text('00:10:00'),
        onPressed: () {
          final _increaseMinute = _minuteController.selectedItem + 10;
          _minuteController.animateToItem(_increaseMinute,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        },
      ),
    );
  }
}
