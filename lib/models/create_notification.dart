import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:my_clock/models/my_alarms.dart';

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
  if (isCalSelected) {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'schedule_channel',
        title: '$title ${Emojis.wheater_droplet}',
        body: 'Hello! This is ur reminder. You have set one to do that work',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(key: 'Mark_Done', label: 'Mark done')
      ],
      schedule: NotificationCalendar.fromDate(
        date: notificationWeekAndTime.dateTime,
        repeats: true,
      ),
    );
  } else {
    for (int i = 0; i < weekDays.length; i++) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id + i,
          channelKey: 'schedule_channel',
          title: '$title ${Emojis.wheater_droplet}',
          body: 'Hello! This is ur reminder. You have set one to do that work',
          notificationLayout: NotificationLayout.Default,
        ),
        actionButtons: [
          NotificationActionButton(key: 'Mark_Done', label: 'Mark done')
        ],
        schedule: NotificationCalendar(
          repeats: true,
          weekday: weekDays[i] + 1,
          hour: notificationWeekAndTime.dateTime.hour,
          minute: notificationWeekAndTime.dateTime.minute,
          second: 0,
          millisecond: 0,
        ),
      );
    }
  }
}

Future<void> cancelScheduleNotifications(MyAlarm myAlarm) async {
  if (myAlarm.isCalSelected) {
    await AwesomeNotifications().cancel(int.parse(myAlarm.id));
  } else {
    for (int i = 0; i < myAlarm.weekDays.length; i++) {
      await AwesomeNotifications().cancel(int.parse(myAlarm.id) + i);
    }
  }
}
