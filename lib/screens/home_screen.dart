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
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 0),
                  child: _selectedIndex == 0
                      ? TappedButton(
                          widget: Image.asset(
                          'assets/clock48.png',
                          fit: BoxFit.cover,
                        ))
                      : MyButton(
                          widget: Image.asset(
                          'assets/clock48.png',
                          fit: BoxFit.cover,
                        ))),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 1),
                  child: _selectedIndex == 1
                      ? TappedButton(
                          widget: Image.asset(
                          'assets/clock32.png',
                          fit: BoxFit.cover,
                        ))
                      : MyButton(
                          widget: Image.asset(
                          'assets/clock32.png',
                          fit: BoxFit.cover,
                        ))),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 2),
                  child: _selectedIndex == 2
                      ? TappedButton(
                          widget: Image.asset(
                          'assets/clock148.png',
                          fit: BoxFit.cover,
                        ))
                      : MyButton(
                          widget: Image.asset(
                          'assets/clock148.png',
                          fit: BoxFit.cover,
                        ))),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 3),
                  child: _selectedIndex == 3
                      ? TappedButton(
                          widget: Image.asset(
                          'assets/clock48.png',
                          fit: BoxFit.cover,
                        ))
                      : MyButton(
                          widget: Image.asset(
                          'assets/clock48.png',
                          fit: BoxFit.cover,
                        ))),
            ),
          ],
        ),
      ),
    );
  }
}
