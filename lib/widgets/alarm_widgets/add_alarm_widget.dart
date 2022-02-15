import 'package:flutter/material.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/item_container.dart';

class AddAlarmWidget extends StatefulWidget {
  const AddAlarmWidget({Key? key}) : super(key: key);

  @override
  _AddAlarmWidgetState createState() => _AddAlarmWidgetState();
}

class _AddAlarmWidgetState extends State<AddAlarmWidget> {
  int h = 0, m = 0, s = 0;
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController(initialItem: 5);
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController(initialItem: 5);
  final day = DateTime.now().day;
  final date = DateTime.now().weekday;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Hour',
                              style: TextStyle(color: Colors.grey[700]!)),
                          Text('Minute',
                              style: TextStyle(color: Colors.grey[700]!)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: size.height * .55,
                        // width: size.width,
                        padding: EdgeInsets.only(
                            bottom: size.height * .05, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _listWheelScroll(size, _hourController, 23, 'h'),
                            const Text(':'),
                            _listWheelScroll(size, _minuteController, 59, 'm'),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: size.height * .5+10,
                      height: size.height * .5-10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: Colors.grey[300],
                        ),
                        child: Column(children: [
                          Padding(
                            padding:const EdgeInsets.all(20),
                            child: Row(children: [
                               Text('Today : $day $date')
                            ],))
                        ],),
                      ),
                      
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listWheelScroll(Size size, FixedExtentScrollController controller,
      int childCount, String text) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .17,
        perspective: 0.008,
        diameterRatio: 1.8,
        useMagnifier: true,
        magnification: 1.1,
        // offAxisFraction: 1,
        onSelectedItemChanged: (value) {
          setState(() => text == 'm' ? m = value : h = value);
        },
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return ItemContainer(
                i: index, selectedText: text, h: h, m: m, s: s);
          },
        ),
      ),
    );
  }
}
