// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['userId'] as int,
    password: json['password'] as String,
    token: json['token'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'password': instance.password,
      'token': instance.token,
      'email': instance.email,
    };
