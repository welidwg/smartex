
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Function(String route)? redirect;
  NotificationService({required this.redirect});


  Future initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("logo");
    var iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInit);
    await notificationPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse res) async {
          final String? action = res.actionId;
          if(action=="goNotif") {

            redirect!("login_screen");
          }
        });
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationPlugin.show(
        id, title, body, await notificationDetails(),payload: payload);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.max, priority: Priority.high,actions: [
              AndroidNotificationAction("goNotif", "Ouvrir l'application",showsUserInterface: true,),
              AndroidNotificationAction("cancelNotif", "Fermer",cancelNotification: true),
            ]),
        iOS: DarwinNotificationDetails());
  }
}
