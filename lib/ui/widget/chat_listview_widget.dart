import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samapp/bloc/chat_bloc.dart';
import 'package:samapp/bloc/event/chat_event.dart';
import 'package:samapp/bloc/state/chat_state.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/ui/chat/item/receiver_message_item.dart';
import 'package:samapp/ui/chat/item/sender_message_item.dart';
import 'package:samapp/ui/common/base_statefull_widget.dart';
import 'package:samapp/utils/constant/dimen.dart';
import 'package:samapp/utils/log/log.dart';

class ChatListViewWidget extends BaseStateFulWidget {
  @override
  _ChatListViewWidgetState createState() => _ChatListViewWidgetState();
}

class _ChatListViewWidgetState extends BaseState<ChatListViewWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ChatBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget getLayout() {
    _bloc = BlocProvider.of<ChatBloc>(context);
    return BlocBuilder<ChatBloc, ChatState>(
      condition: (previousState, state) {
        if (state is ChatInitial || state is ChatGetDataInProgress || state is ChatGetDataSuccess) return true;
        return false;
      },
      builder: (ctx, state) {
        if (state is ChatGetDataInProgress || state is ChatInitial) return buildProgressLoading();
        if (state is ChatGetDataSuccess) return buildMessageList(state.messageList, state.chatUser, state.hasReachedMax);
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }

  ListView buildMessageList(List<Message> messageList, User chatUser, bool hasReachedMax) {
    return ListView.builder(
        reverse: true,
        controller: _scrollController,
        itemCount: hasReachedMax ? messageList.length : messageList.length + 1,
        itemBuilder: (ctx, index) {
          if (index >= messageList.length) return _buildLoadMoreIndicator(context);
          return messageList[index].sender == chatUser.userId.toString()
              ? SenderMessageItem(messageList[index], chatUser.photo)
              : ReceiverMessageItem(messageList[index]);
        });
  }

  Center buildProgressLoading() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(Dimen.spacingSmall),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  Center _buildLoadMoreIndicator(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(Dimen.spacingSmall),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(ChatGetMoreData());
    }
  }
}
