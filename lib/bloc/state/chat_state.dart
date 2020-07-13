import 'package:equatable/equatable.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';

import '../../model/user.dart';

/**
 * State: Initial, InProgress, Success, Failure, Begin, End
 */
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatGetDataInProgress extends ChatState {}

class ChatGetDataSuccess extends ChatState {
  final User chatUser;
  final List<Message> messageList;
  final bool hasReachedMax;
  final int totalItems;

  const ChatGetDataSuccess(this.chatUser, this.messageList, this.hasReachedMax, this.totalItems);

  @override
  List<Object> get props => [messageList, hasReachedMax, totalItems];
}

class ChatFailure extends ChatState {
  final String error;

  const ChatFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ChatSendMessageSuccess extends ChatState {}
