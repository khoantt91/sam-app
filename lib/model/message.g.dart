// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    messageId: json['messageId'] as String,
    content: json['content'] as String,
    sender: json['sender'] as String,
    receiver: json['receiver'] as String,
    chatRoomId: json['chatRoomId'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'content': instance.content,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'createdAt': instance.createdAt,
      'chatRoomId': instance.chatRoomId,
    };
