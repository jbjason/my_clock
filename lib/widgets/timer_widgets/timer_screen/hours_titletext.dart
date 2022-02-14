import 'package:flutter/material.dart';

class HoursMinSecTitleText extends StatelessWidget {
  const HoursMinSecTitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text('Hours'),
          Text('Minutes'),
          Text('Seconds'),
        ],
      ),
    );
  }
}
