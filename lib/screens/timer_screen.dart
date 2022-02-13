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

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: 0);
    _minuteController = FixedExtentScrollController(initialItem: 5);
    _secondController = FixedExtentScrollController(initialItem: 10);
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
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Hours'),
                Text('Minutes'),
                Text('Seconds'),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .6,
            child: Row(
              children: [
                //hours
                _listWheel(size, _hourController, 12),
                // minutes
                _listWheel(size, _minuteController, 61),
                //seconds
                _listWheel(size, _secondController, 61),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemContainer(int i) {
    return Container(
      color: Colors.indigoAccent,
      width: 100,
      child: Center(
        child: Text(
          i.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _listWheel(
      Size size, FixedExtentScrollController controller, int childCount) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .2,
        perspective: 0.007,
        useMagnifier: true,
        //squeeze: 0.9,
        magnification: 1.2,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return _itemContainer(index);
          },
        ),
      ),
    );
  }
}
