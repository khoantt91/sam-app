import 'package:flutter/material.dart';

class NotificationTabScreen extends StatefulWidget {
  const NotificationTabScreen({Key key}) : super(key: key);

  @override
  _NotificationTabScreenState createState() => _NotificationTabScreenState();
}

class _NotificationTabScreenState extends State<NotificationTabScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('Init Notification');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Notification Tab Screen');
  }
}
