import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String messageId;
  String content;
  String sender;
  String receiver;
  int createdAt;
  String chatRoomId;

  Message({this.messageId, this.content, this.sender, this.receiver, this.chatRoomId, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
