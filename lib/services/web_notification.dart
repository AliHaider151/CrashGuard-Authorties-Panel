// Web-only notification handler
import 'dart:developer' as dev;
import 'package:firebase_messaging/firebase_messaging.dart';

void showWebNotification(RemoteMessage message) {
  final title = message.notification?.title ?? "No Title";
  final body = message.notification?.body ?? "No Body";
  dev.log(title.toString());
  dev.log(body.toString());

  // html.Notification.requestPermission().then((permission) {
  //   if (permission == "granted") {
  //     html.Notification(title, body: body);
  //   }
  // });
}
