import 'package:flutter/material.dart';
import 'package:my_clock/widgets/clock_widgets/clock/clock_body.dart';
import 'package:my_clock/widgets/clock_widgets/clock_details/clock_details.dart';
import 'package:my_clock/widgets/clock_widgets/clock_details/international_times.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          const Center(
            child: SizedBox(height: 300, width: 300, child: ClockBody()),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15.0),
            height: size.height * .2,
            child: const ClockDetails(),
          ),
          const Expanded(child: InternationalTimes()),
        ],
      ),
    );
  }
}
