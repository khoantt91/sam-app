// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) {
  return Deal(
    json['dealId'] as int,
    json['customerName'] as String,
    json['statusName'] as String,
    json['statusId'] as int,
    json['listingTypeName'] as String,
    json['propertyTypeName'] as String,
    json['scorecardType'] as String,
    json['formatMinPrice'] as String,
    json['formatMaxPrice'] as String,
    json['districtNames'] as String,
    json['numberTour'] as int,
    (json['listingClassify'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
      'dealId': instance.dealId,
      'customerName': instance.customerName,
      'statusName': instance.statusName,
      'statusId': instance.statusId,
      'listingTypeName': instance.listingTypeName,
      'propertyTypeName': instance.propertyTypeName,
      'scorecardType': instance.scorecardType,
      'formatMinPrice': instance.formatMinPrice,
      'formatMaxPrice': instance.formatMaxPrice,
      'districtNames': instance.districtNames,
      'numberTour': instance.numberTour,
      'listingClassify': instance.listingClassify,
    };
