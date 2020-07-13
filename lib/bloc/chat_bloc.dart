import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:samapp/bloc/event/chat_event.dart';
import 'package:samapp/bloc/state/chat_state.dart';
import 'package:samapp/model/app_error.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/model/repository_result.dart';
import 'package:samapp/repository/repository.dart';
import 'package:samapp/utils/log/log.dart';
import 'package:samapp/utils/utils.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  //region Constructor
  final RepositoryImp _repository;

  ChatBloc(this._repository);

  //endregion

  //region Variables
  User _chatUser;
  User _currentUser;
  String _chatRoomId;

  final List<Message> messageList = [];
  Message _lastMessage;
  int _totalItems = 0;

  StreamSubscription<RepositoryResult<Message, AppError>> _streamNewMessage;

  //endregion

  @override
  ChatState get initialState => ChatInitial();

  @override
  Stream<Transition<ChatEvent, ChatState>> transformEvents(Stream<ChatEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) => event is! ChatGetMoreData);
    final debounceStream = events.where((event) => event is ChatGetMoreData).debounceTime(Duration(milliseconds: 500));
    return super.transformEvents(MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatGetData) yield* _handleGetData(event);
    if (event is ChatGetMoreData) yield* _handleGetMoreData(event);
    if (event is ChatSendMessage) yield* _handleSendMessage(event);
    if (event is ChatNewMessageComing) yield* _handleNewMessageComing(event);
  }

  Stream<ChatState> _handleGetData(ChatGetData event) async* {
    yield ChatGetDataInProgress();

    /* Step 1: Get current user */
    if (event.chatUser != null) _chatUser = event.chatUser;

    if (_currentUser == null) {
      final userResult = await _repository.getCurrentUser();

      if (userResult.error != null) {
        yield ChatFailure(userResult.error.message);
        return;
      }
      _currentUser = userResult.success;
    }

    /* Step 2: Get chatRoomId or create a new chatRoomId */
    if (_chatRoomId == null) {
      final chatRoomResult = await _repository.getOrCreateChatRoomId([_currentUser, _chatUser]);

      if (chatRoomResult.error != null) {
        yield ChatFailure(chatRoomResult.error.message);
        return;
      }

      _chatRoomId = chatRoomResult.success;
    }

    /* Step 3: Get all message in chatRoomId */
    final allMessageResult = await _repository.getAllMessageInRoom(_chatRoomId);

    if (allMessageResult.error != null) {
      yield ChatFailure(allMessageResult.error.message);
      return;
    }

    messageList.replaceAll(allMessageResult.success.list);
    _totalItems = allMessageResult.success.totalItems;

    if (messageList.length > 0) {
      _lastMessage = messageList[messageList.length - 1];
    }
    yield ChatGetDataSuccess(_chatUser, List.from(messageList), messageList.length >= _totalItems, _totalItems);

    /* Step 4: Register observer new message */
    if (_streamNewMessage == null) {
      _streamNewMessage = _repository.observerNewMessage(_chatRoomId).listen((result) {
        add(ChatNewMessageComing(result.success));
      });
    }
  }

  Stream<ChatState> _handleGetMoreData(ChatGetMoreData event) async* {
    if (messageList.length >= _totalItems) {
      Log.i('LOAD DONE => REACHED MAX LIST');
      return;
    }

    final allMessageResult = await _repository.getAllMessageInRoom(_chatRoomId, lastMessage: _lastMessage);

    if (allMessageResult.error != null) {
      yield ChatFailure(allMessageResult.error.message);
      return;
    }

    messageList.addAll(allMessageResult.success.list);
    _totalItems = allMessageResult.success.totalItems;
    if (messageList.length > 0) {
      _lastMessage = messageList[messageList.length - 1];
    }
    yield ChatGetDataSuccess(_chatUser, List.from(messageList), messageList.length >= _totalItems, _totalItems);
  }

  Stream<ChatState> _handleSendMessage(ChatSendMessage event) async* {
    if (event.message.isEmpty == true) return;
    final message = Message(
        content: event.message,
        sender: _currentUser.userId.toString(),
        receiver: _chatUser.userId.toString(),
        chatRoomId: _chatRoomId,
        createdAt: DateTime.now().millisecondsSinceEpoch);

    yield ChatSendMessageSuccess();
    _repository.insertMessage(message);
    final tokenList = await _repository.getUserFirebaseTokens(_chatUser);
    sendNotificationMessage(message.content, _currentUser, tokenList.success.list);
  }

  Stream<ChatState> _handleNewMessageComing(ChatNewMessageComing event) async* {
    Log.i('NEW MESSAGE = ${event.message.content} !!!!');
    messageList.insert(0, event.message);
    yield ChatGetDataSuccess(_chatUser, List.from(messageList), messageList.length < _totalItems, _totalItems);
  }

  @override
  Future<void> close() {
    _streamNewMessage?.cancel();
    return super.close();
  }
}

extension ListExtention<T> on List<T> {
  void replaceAll(List<T> newList) {
    this.clear();
    this.addAll(newList);
  }
}
