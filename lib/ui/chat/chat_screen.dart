import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/chat_bloc.dart';
import 'package:samapp/bloc/event/chat_event.dart';
import 'package:samapp/bloc/state/chat_state.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/chat/item/receiver_message_item.dart';
import 'package:samapp/ui/chat/item/sender_message_item.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/widget/chat_listview_widget.dart';
import 'package:samapp/ui/widget/chat_text_field_widget.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';
import 'package:samapp/utils/utils.dart';

class ChatScreen extends BaseStateFulWidget {
  static const routerName = '/chat-screen/';

  final User _chatUser;

  ChatScreen(this._chatUser);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  ChatBloc _chatBloc;

  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    /* Get data on first time after 200 milliseconds */
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _chatBloc.add(ChatGetData(widget._chatUser));
    });
  }

  @override
  Widget getLayout() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Theme.of(context).secondaryHeaderColor));

    /* Common App Bar */
    final appBar = CommonAppBar(
      widget._chatUser.name,
      showSearchIcon: false,
      showShareIcon: false,
      showBackIcon: true,
      statusBarHeight: MediaQuery.of(context).padding.top,
    );

    String _currentErrorMessage = '';

    return BlocProvider<ChatBloc>(
      create: (context) {
        _chatBloc = ChatBloc(RepositoryProvider.of<RepositoryImp>(context));
        return _chatBloc;
      },
      child: BlocListener<ChatBloc, ChatState>(
        listener: (ctx, state) {
          /* Handle Error */
          if (state is ChatFailure) {
            if (_currentErrorMessage == state.error) return;
            _currentErrorMessage = state.error;
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _currentErrorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                backgroundColor: Colors.white,
                duration: Duration(seconds: 1),
              ),
            );
            return;
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: appBar,
          body: LayoutBuilder(builder: (ctx, constraint) {
            return Stack(
              children: [
                Container(height: constraint.maxHeight - 56, child: ChatListViewWidget()),
                Align(alignment: Alignment.bottomCenter, child: Container(height: 56, child: ChatTextFieldWidget(_messageController, _sendMessage))),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _sendMessage() async {
    _chatBloc.add(ChatSendMessage(_messageController.text.toString()));
    _messageController.text = "";
  }
}
