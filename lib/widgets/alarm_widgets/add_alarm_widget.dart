import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_clock/widgets/alarm_widgets/title_textField.dart';
import 'package:my_clock/widgets/timer_widgets/timer_screen/item_container.dart';
import 'package:my_clock/widgets/timer_widgets/white_button.dart';

class AddAlarmWidget extends StatefulWidget {
  const AddAlarmWidget({Key? key}) : super(key: key);

  @override
  _AddAlarmWidgetState createState() => _AddAlarmWidgetState();
}

class _AddAlarmWidgetState extends State<AddAlarmWidget> {
  int h = 2, m = 2, s = 0;
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController(initialItem: 2);
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController(initialItem: 2);
  final _titleController = TextEditingController();
  final String date = DateFormat('EEEE, d MMM').format(DateTime.now());
  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                      top: size.height * .5 + 10,
                      child: Container(
                        height: size.height * .47 ,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          children: [
                            // todays Date & Calender
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Today : $date',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  IconButton(
                                      icon: Icon(CupertinoIcons.calendar,
                                          size: 30, color: Colors.grey[800]),
                                      onPressed: () {})
                                ],
                              ),
                            ),
                            // weekDays
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weekDays.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17, right: 17),
                                    child: Text(weekDays[index],
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                  ),
                                ),
                              ),
                            ),
                            // title textField
                            TitleTextFormField(
                                titleController: _titleController),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: const WhiteButton(text: 'Cancel'),
                                  onTap: () {},
                                ),
                                InkWell(
                                  child: const WhiteButton(text: 'Save'),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
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
