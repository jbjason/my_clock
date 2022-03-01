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
  List<int> weekDays,
  NotificationWeekAndTime notificationWeekAndTime,
) async {
//  for (int i = 0; i < weekDays.length; i++) {
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
            )
          : NotificationCalendar(
              repeats: true,
              weekday:notificationWeekAndTime.dayOfTheWeek,
              hour: notificationWeekAndTime.dateTime.hour,
              minute: notificationWeekAndTime.dateTime.minute,
              second: 0,
              millisecond: 0,
            ),
    );
 // }
}

Future<void> cancelScheduleNotifications(int id) async {
  await AwesomeNotifications().cancel(id);
}
