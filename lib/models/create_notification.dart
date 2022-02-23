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
  bool isCalSelected,
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
    schedule: isCalSelected
        ? NotificationCalendar.fromDate(
            date: notificationWeekAndTime.dateTime,
            repeats: true,
            // year: notificationWeekAndTime.dateTime.year,
            // month: notificationWeekAndTime.dateTime.month,
            // day: notificationWeekAndTime.dateTime.day,
            // hour: notificationWeekAndTime.dateTime.hour,
            // minute: notificationWeekAndTime.dateTime.minute,
            // second: notificationWeekAndTime.dateTime.second,
            // millisecond: notificationWeekAndTime.dateTime.microsecond,
          )
        : NotificationCalendar(
            repeats: true,
            weekday: notificationWeekAndTime.dayOfTheWeek,
            hour: notificationWeekAndTime.dateTime.hour,
            minute: notificationWeekAndTime.dateTime.minute,
            second: 0,
            millisecond: 0,
          ),
  );
}

Future<void> cancelScheduleNotifications(int id) async {
  await AwesomeNotifications().cancel(id);
}
