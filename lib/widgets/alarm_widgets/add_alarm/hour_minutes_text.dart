import 'package:flutter/material.dart';

class HourMinutesText extends StatelessWidget {
  const HourMinutesText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Hour', style: TextStyle(color: Colors.grey[700]!)),
        Text('Minute', style: TextStyle(color: Colors.grey[700]!)),
      ],
    );
  }
}