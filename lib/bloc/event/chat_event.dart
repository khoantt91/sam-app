import 'package:equatable/equatable.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatGetData extends ChatEvent {
  final User chatUser;

  ChatGetData(this.chatUser);

  @override
  List<Object> get props => [chatUser];
}

class ChatGetMoreData extends ChatEvent {}

class ChatSendMessage extends ChatEvent {
  final String message;

  ChatSendMessage(this.message);
}

class ChatStartObserverNewMessage extends ChatEvent {}

class ChatStopObserverNewMessage extends ChatEvent {}

class ChatNewMessageComing extends ChatEvent {
  final Message message;

  ChatNewMessageComing(this.message);
}
