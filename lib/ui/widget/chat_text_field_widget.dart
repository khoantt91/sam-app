import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/widget/common_app_password_text_field.dart';
import 'package:samapp/utils/constant/dimen.dart';

class ChatTextFieldWidget extends BaseStateFulWidget {
  Function _sendMessage;
  TextEditingController _messageController;

  ChatTextFieldWidget(this._messageController, this._sendMessage);

  @override
  _ChatTextFieldWidgetState createState() => _ChatTextFieldWidgetState();
}

class _ChatTextFieldWidgetState extends BaseState<ChatTextFieldWidget> {
  @override
  Widget getLayout() {
    final repository = RepositoryProvider.of<RepositoryImp>(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: widget._messageController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            errorBorder: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: widget._sendMessage,
              child: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
            )),
      ),
    );
  }
}
