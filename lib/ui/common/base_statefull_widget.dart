import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseStateFulWidget extends StatefulWidget {
  BaseStateFulWidget({Key key}) : super(key: key);
}

abstract class BaseState<B extends BaseStateFulWidget> extends State<B> {
  /// should be overridden in extended widget
  Widget getLayout();

  @override
  Widget build(BuildContext context) {
    return getLayout();
  }

  //region Private Support Methods
  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void showErrorSnackbar(String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 1),
    ));
  }
//endregion

}
