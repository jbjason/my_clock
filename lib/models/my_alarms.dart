import 'package:flutter/cupertino.dart';

class MyAlarm {
  final String id;
  final List<String> weekDays;
  final DateTime date;
  const MyAlarm({required this.id, required this.weekDays, required this.date});
}


class MyAlarms extends ChangeNotifier{
  List<MyAlarm> _items = [];

  List<MyAlarm> get items {
    return [..._items];
  }
  
}
