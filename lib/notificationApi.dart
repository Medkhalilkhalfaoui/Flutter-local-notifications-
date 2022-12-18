


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();


  static Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();

    // #2
    const initSettings = InitializationSettings(android: androidSetting, iOS: iosSetting);
    await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse:(payload)async{
          onNotification.add(payload.payload);
        },
    );

    // #3
    // await _notifications.initialize(initSettings).then((_) {
    //   debugPrint('setupPlugin: setup success');
    // }).catchError((Object error) {
    //   debugPrint('Error: $error');
    // });
  }


  static Future _notificationDetails()async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id 8',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max

      ),
      iOS: DarwinNotificationDetails()
    );

  }

  static Future showNotification({int id =0,String? title,String? body,String? playload,}) async{
    _notifications.show(id, title, body, await _notificationDetails(),payload: playload);
  }

  static Future showScheduledNotification({int id =1,String? title,String? body,String? playload,required DateTime scheduledDate}) async{

    _notifications.zonedSchedule(
        id, title, body,
       tz.TZDateTime.from(scheduledDate, tz.local),
       // scheduledDate,
      //RepeatInterval.everyMinute,
        await _notificationDetails(),
        payload: playload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime

    );
  }
  static void cancel (int id) => _notifications.cancel(id);



}