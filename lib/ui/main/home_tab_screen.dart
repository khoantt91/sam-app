import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/onboarding/splash_screen.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/utils/constant/dimen.dart';

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

  void _logout(BuildContext context) async {
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final logoutResult = await repository.logout('Android');
    if (logoutResult.success != null) {
      Fluttertoast.showToast(
        msg: 'Logout successuflly',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pushReplacementNamed(SplashScreenWidget.routerName);
    } else {
      Fluttertoast.showToast(
        msg: 'Logout error = ${logoutResult.error.message}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CommonAppBar(
        'HomeScreen',
        statusBarHeight: MediaQuery.of(context).padding.top,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: Dimen.spacingNormal,
          ),
          RaisedButton(
            child: Text('Logout'),
            onPressed: () => {_logout(context)},
          ),
          Container(
            height: 500,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Home Screen'),
                    subtitle: Text('$index'),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
