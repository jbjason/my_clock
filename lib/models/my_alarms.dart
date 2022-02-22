import 'package:flutter/cupertino.dart';

class MyAlarm {
  final String id, title;
  final List<int> weekDays;
  final DateTime date;
  const MyAlarm(
      {required this.id,
      required this.title,
      required this.weekDays,
      required this.date});
}

class MyAlarms extends ChangeNotifier {
  final List<MyAlarm> _items = [
    MyAlarm(id: '123', title: 'Jb Jason', weekDays: [3,1,5,3,4,0,6], date: DateTime.now()),
    MyAlarm(
        id: '132', title: 'Loser & CO', weekDays: [3,1,5,3,4,0,6], date: DateTime.now()),
  ];

  List<MyAlarm> get items {
    return [..._items];
  }

  void addAlarm(MyAlarm myAlarm) {
    _items.add(myAlarm);
    notifyListeners();
  }
}
