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
  )
    ..name = json['name'] as String
    ..photo = json['photo'] as String
    ..isOnline = json['isOnline'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'password': instance.password,
      'token': instance.token,
      'email': instance.email,
      'photo': instance.photo,
      'isOnline': instance.isOnline,
    };
