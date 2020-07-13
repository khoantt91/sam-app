import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements Equatable {
  int userId;
  String name;
  String password;
  String token;
  String email;
  String photo;

  bool isOnline;

  User({this.userId, this.password, this.token, this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [userId];

  @override
  bool get stringify => false;
}
