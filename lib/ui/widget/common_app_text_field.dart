import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/login_bloc.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/utils/constant/dimen.dart';

class CommonAppTextField extends StatefulWidget {
  TextEditingController _controller;
  String _hintText;

  CommonAppTextField(this._controller, this._hintText);

  @override
  _CommonAppTextFieldState createState() => _CommonAppTextFieldState();
}

class _CommonAppTextFieldState extends State<CommonAppTextField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
        margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
        child: TextField(
          controller: widget._controller,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            FocusScope.of(context).nextFocus();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).hoverColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).hoverColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).hoverColor, width: 1.0),
            ),
            hintText: widget._hintText,
            prefixIcon: Icon(Icons.account_circle),
            errorText: state is LoginErrorUserName ? state.error : null,
          ),
        ),
      );
    });
  }
}
