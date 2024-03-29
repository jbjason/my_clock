import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFE0E0E0),
    systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Color.fromARGB(255, 233, 229, 229),
  ));
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'schedule_channel',
      channelName: 'Scheduled Notifications',
      channelDescription: 'Notification channel for schedule tests',
      defaultColor: Colors.grey,
      importance: NotificationImportance.High,
      locked: false,
      soundSource: 'resource://raw/res_custom_notification',
      channelShowBadge: true,
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAlarms(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFFE0E0E0),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
