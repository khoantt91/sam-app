// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkResponse _$NetworkResponseFromJson(Map<String, dynamic> json) {
  return NetworkResponse(
    json['result'] as bool,
    json['code'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$NetworkResponseToJson(NetworkResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'code': instance.code,
      'message': instance.message,
    };
