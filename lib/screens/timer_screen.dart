import 'package:flutter/material.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/hours_titletext.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/minute_add_ten_more.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/start_bottom_button.dart';
import 'package:my_clock/widgets/timer_widgets/countdown_screen/timer_clock.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController(initialItem: 5);
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController(initialItem: 5);
  final FixedExtentScrollController _secondController =
      FixedExtentScrollController(initialItem: 5);
  int h = 5, m = 5, s = 5;
  bool _isTimerSet = false;

  void changeTimerMode() {
    setState(() => _isTimerSet = !_isTimerSet);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _isTimerSet
        ? TimerClock(
            initDuraion: Duration(hours: h, minutes: m, seconds: s),
            changeTimerMode: changeTimerMode,
          )
        : Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title Hour Min Sec text
                  const HoursMinSecTitleText(),
                  // ListWheels of sec,min,hour
                  Container(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    height: size.height * .48,
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        //hours
                        _listWheel(size, _hourController, 12, 'h'),
                        // minutes
                        _listWheel(size, _minuteController, 61, 'm'),
                        //seconds
                        _listWheel(size, _secondController, 61, 's'),
                      ],
                    ),
                  ),
                  // Add Ten minutes
                  MinuteAddTenMore(minuteController: _minuteController),
                  const SizedBox(height: 10),
                  // start button
                  InkWell(
                    onTap: () => changeTimerMode(),
                    child: const StartButtonBottom(),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _listWheel(Size size, FixedExtentScrollController controller,
      int childCount, String text) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .17,
        perspective: 0.008,
        diameterRatio: 1.8,
        useMagnifier: true,
        magnification: 1.1,
        offAxisFraction: text == 'm'
            ? 0
            : text == 's'
                ? 0.9
                : -0.9,
        onSelectedItemChanged: (value) {
          setState(() => text == 'm'
              ? m = value
              : text == 's'
                  ? s = value
                  : h = value);
        },
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return _itemContainer(index, text);
          },
        ),
      ),
    );
  }

  Widget _itemContainer(int i, String selectedText) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        // for minutes & seconds using 0(prefix) where its lower than 10
        child: Text(
          (selectedText == 's' || selectedText == 'm') && i < 10
              ? '0' + i.toString()
              : i.toString(),
          style: TextStyle(
            // if selected index second hoy & secondIndex current ==i then grey[900]
            color: selectedText == 's' && s == i ||
                    selectedText == 'm' && m == i ||
                    selectedText == 'h' && h == i
                ? Colors.grey[800]
                : Colors.grey[600],
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 3,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
  }
}
