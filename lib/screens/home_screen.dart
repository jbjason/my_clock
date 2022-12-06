import 'package:flutter/material.dart';
import 'package:my_clock/screens/alarm_screen.dart';
import 'package:my_clock/screens/clock_screen.dart';
import 'package:my_clock/screens/stop_watch_screen.dart';
import 'package:my_clock/screens/timer_screen.dart';
import 'package:my_clock/widgets/common_widgets/navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final List<Widget> _screens = const [
    AlarmScreen(),
    ClockScreen(),
    StopWatchScreen(),
    TimerScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, int currentIndex, _) => Scaffold(
        body: _screens[currentIndex],
        bottomNavigationBar: NavBar(selectedIndex: _selectedIndex),
      ),
    );
  }
}
