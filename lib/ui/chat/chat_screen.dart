import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/ui/chat/item/receiver_message_item.dart';
import 'package:samapp/ui/chat/item/sender_message_item.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/ui/widget/chat_text_field_widget.dart';
import 'package:samapp/ui/widget/common_app_bar.dart';
import 'package:samapp/utils/log/log.dart';

class ChatScreen extends BaseStateFulWidget {
  static const routerName = '/chat-screen/';

  final User _chatUser;

  ChatScreen(this._chatUser);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen> {
  List<Message> _messageList = [];
  User _currentUser;
  String _chatRoomId;
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllMessage();
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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - appBar.preferredSize.height - 56,
              child: ListView.builder(
                reverse: true,
                itemCount: _messageList.length,
                itemBuilder: (ctx, index) => _messageList[index].sender != _currentUser.userId.toString()
                    ? SenderMessageItem(_messageList[index], widget._chatUser.photo)
                    : ReceiverMessageItem(_messageList[index]),
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: Container(height: 56, child: ChatTextFieldWidget(_messageController, _sendMessage))),
          ],
        ),
      ),
    );
  }

  void _getAllMessage() async {
    final repository = RepositoryProvider.of<RepositoryImp>(context);

    final userResult = await repository.getCurrentUser();
    this._currentUser = userResult.success;

    final chatRoomResult = await repository.getOrCreateChatRoomId([this._currentUser, widget._chatUser]);
    this._chatRoomId = chatRoomResult.success;

    final allMessageResult = await repository.getAllMessageInRoom(this._chatRoomId);

    allMessageResult.success.list.forEach((element) {
      Log.i('Message=${element.content}');
    });
    setState(() {
      _messageList.addAll(allMessageResult.success.list);
    });
  }

  void _sendMessage() async {
    Log.w('Send new message = ${_messageController.text.toString()}');
    final message = Message(
        content: _messageController.text.toString(),
        sender: _currentUser.userId.toString(),
        receiver: widget._chatUser.userId.toString(),
        chatRoomId: _chatRoomId,
        createdAt: DateTime.now().millisecondsSinceEpoch);
    final repository = RepositoryProvider.of<RepositoryImp>(context);
    final result = await repository.insertMessage(message);
    setState(() {
      _messageList.insert(0, message);
    });
  }
}
