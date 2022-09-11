import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_clock/screens/alarm_screen.dart';
import 'package:my_clock/screens/clock_screen.dart';
import 'package:my_clock/screens/stop_watch_screen.dart';
import 'package:my_clock/screens/timer_screen.dart';
import 'package:my_clock/widgets/home_widgets/my_button.dart';
import 'package:my_clock/widgets/home_widgets/tapped_button.dart';

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

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.selectedIndex}) : super(key: key);
  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xFFEBF3FE),
          border: Border.all(
              color: const Color(0xFF3F6080).withOpacity(.2), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(0, CupertinoIcons.alarm),
            _navItem(1, CupertinoIcons.clock),
            _navItem(2, CupertinoIcons.stopwatch_fill),
            _navItem(3, CupertinoIcons.timer),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon) => InkWell(
        onTap: () => selectedIndex.value = index,
        child: index == selectedIndex.value
            ? TappedButton(widget: Icon(icon))
            : MyButton(widget: Icon(icon)),
      );
}
