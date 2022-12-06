import 'package:flutter/material.dart';
import 'package:my_clock/widgets/common_widgets/wheel_item.dart';

class WheelList extends StatelessWidget {
  const WheelList(
      {Key? key,
      required this.onSelectedItemChanged,
      required this.hourController,
      required this.minuteController,
      required this.h,
      required this.m,
      required this.s})
      : super(key: key);
  final void Function(int value, String text) onSelectedItemChanged;
  final FixedExtentScrollController hourController;
  final FixedExtentScrollController minuteController;
  final int h, m, s;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .52,
      // width: size.width,
      padding: EdgeInsets.only(bottom: size.height * .05, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _listWheelScroll(size, hourController, 24, 'h'),
          Text(':', style: TextStyle(height: 30, color: Colors.grey[600])),
          _listWheelScroll(size, minuteController, 60, 'm'),
        ],
      ),
    );
  }

  Widget _listWheelScroll(Size size, FixedExtentScrollController controller,
      int childCount, String _text) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: size.height * .17,
        perspective: 0.008,
        diameterRatio: 1.8,
        useMagnifier: true,
        magnification: 1.1,
        onSelectedItemChanged: (value) => onSelectedItemChanged(value, _text),
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: childCount,
          builder: (context, index) {
            return WheelItem(i: index, selectedText: _text, h: h, m: m, s: s);
          },
        ),
      ),
    );
  }
}
