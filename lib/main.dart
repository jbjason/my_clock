import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_clock/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFEBF3FE),
    systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Color(0xFFEBF3FE), // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFEBF3FE),
      ),
      home: const HomeScreen(),
    );
  }
}
