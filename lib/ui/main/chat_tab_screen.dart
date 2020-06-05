import 'package:flutter/material.dart';

class ChatTabScreen extends StatefulWidget {

  const ChatTabScreen({Key key}) : super(key: key);

  @override
  _ChatTabScreenState createState() => _ChatTabScreenState();
}

class _ChatTabScreenState extends State<ChatTabScreen> {

  @override
  void initState() {
    // TODO: implement initState
    print('Init Chat');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(alignment: Alignment.center, child: Text('Chat Tab Screen')),
    );
  }
}
