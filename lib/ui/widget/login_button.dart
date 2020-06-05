import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samapp/bloc/event/login_event.dart';
import 'package:samapp/bloc/login_bloc.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/ui/main/main_tab_screen.dart';
import 'package:samapp/utils/constant/dimen.dart';

class LoginButton extends StatefulWidget {
  final String _userName;
  final String _password;

  const LoginButton(this._userName, this._password);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.error}',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
              duration: Duration(seconds: 1),
            ),
          );
          return;
        }

        if (state is LoginSuccess) {
          Fluttertoast.showToast(
            msg: S.of(context).common_sign_in_success,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          Navigator.of(context).pushReplacementNamed(MainTabScreen.routerName);
          return;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return state == LoginLoading()
            ? Container(
                margin: EdgeInsets.all(Dimen.spacingSmall),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              )
            : Container(
                height: Dimen.buttonHeightNormal,
                margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
                child: RaisedButton(
                  onPressed: _login,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffF17423), Color(0xffFCA741)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).common_sign_in,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }

  void _login() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPress(widget._userName, widget._password));
  }
}
