import 'package:flutter/cupertino.dart';

class MyAlarm {
  final String id, title;
  final List<int> weekDays;
  final DateTime date;
  final bool isCalSelected;
  const MyAlarm(
      {required this.id,
      required this.title,
      required this.weekDays,
      required this.date,
      required this.isCalSelected});
}

class MyAlarms extends ChangeNotifier {
  final List<MyAlarm> _items = [
    MyAlarm(
        id: '123',
        title: 'Jb Jason',
        weekDays: [0, 3, 4, 6],
        date: DateTime.now(),
        isCalSelected: false),
    MyAlarm(
        id: '132',
        title: 'Loser & CO',
        weekDays: [1, 2, 5],
        date: DateTime.now(),
        isCalSelected: false),
  ];

  List<MyAlarm> get items {
    return [..._items];
  }

  void addAlarm(MyAlarm myAlarm) {
    _items.add(myAlarm);
    notifyListeners();
  }

  void deleteAlarms(List<MyAlarm> myItems) {
    for (int i = 0; i < myItems.length; i++) {
      if (myItems[i].id == _items[i].id) {
        _items.remove(myItems[i]);
      }
    }
    notifyListeners();
  }
}
