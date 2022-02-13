import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _secondController;
  int h = 5, m = 5, s = 10;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: h);
    _minuteController = FixedExtentScrollController(initialItem: m);
    _secondController = FixedExtentScrollController(initialItem: s);
  }

  @override
  void dispose() {
    super.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Hours'),
                Text('Minutes'),
                Text('Seconds'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 5, left: 5),
            height: size.height * .5,
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
          Container(
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
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                }),
          ),
        ],
      ),
    );
  }

  Widget _listWheel(Size size, FixedExtentScrollController controller,
      int childCount, String text) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .15,
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
}
