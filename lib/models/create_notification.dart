import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final DateTime dateTime;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.dateTime,
  });
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<void> createScheduleNotification(
  int id,
  String title,
  NotificationWeekAndTime notificationWeekAndTime,
) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'schedule_channel',
      title: '$title${Emojis.wheater_droplet}',
      body: 'Hello !! this is ur reminder',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(key: 'Mark_Done', label: 'Mark done'),
    ],
    schedule: NotificationCalendar(
      repeats: true,
      weekday: notificationWeekAndTime.dayOfTheWeek,
      hour: notificationWeekAndTime.dateTime.hour,
      minute: notificationWeekAndTime.dateTime.minute,
      year: notificationWeekAndTime.dateTime.year,
      month: notificationWeekAndTime.dateTime.month,
      second: notificationWeekAndTime.dateTime.second,
      millisecond: notificationWeekAndTime.dateTime.microsecond,
    ),
  );
}

Future<void> cancelScheduleNotifications(int id) async {
  await AwesomeNotifications().cancel(id);
}
