import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samapp/main.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/utils/log/log.dart';

Future<Map<String, dynamic>> sendNotificationMessage(String message, User sender, List<String> firebaseTokens) async {
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  /* Config Dio */
  final options = BaseOptions(
    baseUrl: 'https://fcm.googleapis.com/fcm/',
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  final _dio = Dio(options);

  /* Add log interceptor */

  _dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  ));

  await _dio.post(
    'send',
    options: Options(headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    }),
    data: jsonEncode(<String, dynamic>{
      'notification': <String, dynamic>{'body': message, 'title': sender.name},
      'priority': 'high',
      'data': <String, dynamic>{'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'id': '1', 'status': 'done'},
      'registration_ids': firebaseTokens,
    }),
  );
}

Future showNotificationWithDefaultSound(Map<String, dynamic> notificationMessage) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);

  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    notificationMessage['notification']['title'],
    notificationMessage['notification']['body'],
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}
