import 'package:flutter/material.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key key}) : super(key: key);

  @override
  _HomeTabScreen createState() => _HomeTabScreen();
}

class _HomeTabScreen extends State<HomeTabScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('Init Home');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
        return ListTile(
          title: Text('Home Screen'),
          subtitle: Text('$index'),
        );
      }),
    );
  }
}
