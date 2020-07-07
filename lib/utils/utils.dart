import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samapp/utils/log/log.dart';

final String serverToken = 'AAAAS1mvmr8:APA91bGTfXYhVobH3B3lrz5i5FaW8JqqloZRJi9FpC6ga5xoVli0nvmI9ZVnLlNMT3j929nVO4ktkxaqrEzwMYHNhx6UZ8JkFUabCgW1sk92dIoodfNm_A1trzxgsnPTWMY7tCQ0-tKy';
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

Future<Map<String, dynamic>> sendAndRetrieveMessage() async {

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
      'notification': <String, dynamic>{'body': 'this is a body', 'title': 'this is a title'},
      'priority': 'high',
      'data': <String, dynamic>{'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'id': '1', 'status': 'done'},
      'to': await firebaseMessaging.getToken(),
    }),
  );

  final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      Log.w('New Message=$message');
      await _showNotificationWithDefaultSound('Notificaiton Test', 'Hello World');
      completer.complete(message);
    },
  );

  return completer.future;
}

Future _showNotificationWithDefaultSound(String title, String message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    '$title',
    '$message',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}
