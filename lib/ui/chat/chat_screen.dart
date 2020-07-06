import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/ui/chat/item/receiver_message_item.dart';
import 'package:samapp/ui/chat/item/sender_message_item.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/widget/chat_text_field_widget.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';

class ChatScreen extends BaseStateFulWidget {
  static const routerName = '/chat-screen/';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  @override
  Widget getLayout() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Theme.of(context).secondaryHeaderColor));
    final User chatUser = ModalRoute.of(buildContext).settings.arguments as User;

    /* Common App Bar */
    final appBar = CommonAppBar(
      chatUser.name,
      showSearchIcon: false,
      showShareIcon: false,
      showBackIcon: true,
      statusBarHeight: MediaQuery.of(context).padding.top,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => index % 3 == 0 ? ReceiverMessageItem() : SenderMessageItem(),
                  )),
              ChatTextFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
