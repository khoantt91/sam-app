import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/login_bloc.dart';
import 'package:samapp/bloc/state/login_state.dart';
import 'package:samapp/utils/constant/dimen.dart';

class CommonAppPasswordTextField extends StatefulWidget {
  TextEditingController _controller;
  String _hintText;

  CommonAppPasswordTextField(this._controller, this._hintText);

  @override
  _CommonAppTextFieldState createState() => _CommonAppTextFieldState();
}

class _CommonAppTextFieldState extends State<CommonAppPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (ctx, state) {
      return Container(
        margin: EdgeInsets.only(left: Dimen.spacingNormal, right: Dimen.spacingNormal),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: widget._controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).hoverColor,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hoverColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hoverColor,
                ),
              ),
              errorText: state is LoginErrorPassword ? state.error : null,
              hintText: widget._hintText,
              prefixIcon: Icon(Icons.lock),
              errorBorder: InputBorder.none,
              suffixIcon: GestureDetector(
                child: _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                onTap: _showHidePassword,
              )),
        ),
      );
    });
  }

  void _showHidePassword() {
    setState(() {
      _obscureText = _obscureText != true;
    });
  }
}
