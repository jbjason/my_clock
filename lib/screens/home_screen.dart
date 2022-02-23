import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/screens/alarm_screen.dart';
import 'package:my_clock/screens/clock_screen.dart';
import 'package:my_clock/screens/stop_watch_screen.dart';
import 'package:my_clock/screens/timer_screen.dart';
import 'package:my_clock/widgets/home_widgets/my_button.dart';
import 'package:my_clock/widgets/home_widgets/tapped_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    ClockScreen(),
    AlarmScreen(),
    StopWatchScreen(),
    TimerScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // const Color(0xFFEBF3FE) :  clock actuall background
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFFEBF3FE),
              border: Border.all(color: Colors.grey[400]!, width: 2)),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: _selectedIndex == 0
                        ? const TappedButton(widget: Icon(CupertinoIcons.clock))
                        : const MyButton(widget: Icon(CupertinoIcons.clock))),
              ),
              Expanded(
                child: InkWell(
                    onTap: () => setState(() => _selectedIndex = 1),
                    child: _selectedIndex == 1
                        ? const TappedButton(widget: Icon(CupertinoIcons.alarm))
                        : const MyButton(widget: Icon(CupertinoIcons.alarm))),
              ),
              Expanded(
                child: InkWell(
                    onTap: () => setState(() => _selectedIndex = 2),
                    child: _selectedIndex == 2
                        ? const TappedButton(
                            widget: Icon(CupertinoIcons.stopwatch_fill))
                        : const MyButton(
                            widget: Icon(CupertinoIcons.stopwatch_fill))),
              ),
              Expanded(
                child: InkWell(
                    onTap: () => setState(() => _selectedIndex = 3),
                    child: _selectedIndex == 3
                        ? const TappedButton(widget: Icon(CupertinoIcons.timer))
                        : const MyButton(widget: Icon(CupertinoIcons.timer))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
