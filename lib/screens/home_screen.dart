import 'package:flutter/material.dart';
import 'package:my_clock/screens/clock_screen.dart';
import 'package:my_clock/screens/stop_watch_screen.dart';
import 'package:my_clock/screens/timer_screen.dart';
import 'package:my_clock/widgets/home_widgets/my_Button.dart';
import 'package:my_clock/widgets/home_widgets/tapped_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const StopWatchScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 0),
                  child: _selectedIndex == 0
                      ? const TappedButton(icon: Icons.home)
                      : const MyButton(icon: Icons.home)),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 1),
                  child: _selectedIndex == 1
                      ? const TappedButton(icon: Icons.set_meal)
                      : const MyButton(icon: Icons.set_meal)),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 2),
                  child: _selectedIndex == 2
                      ? const TappedButton(icon: Icons.pending)
                      : const MyButton(icon: Icons.pending)),
            ),
            Expanded(
              child: InkWell(
                  onTap: () => setState(() => _selectedIndex = 3),
                  child: _selectedIndex == 3
                      ? const TappedButton(icon: Icons.message_sharp)
                      : const MyButton(icon: Icons.message_sharp)),
            ),
          ],
        ),
      ),
    );
  }
}
