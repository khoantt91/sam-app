// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listing _$ListingFromJson(Map<String, dynamic> json) {
  return Listing(
    json['rlistingId'] as int,
    json['scorecardType'] as int,
    json['formatPrice'] as String,
    json['formatFloorSize'] as String,
    json['formatLotSize'] as String,
    json['address'] as String,
    json['classify'] as int,
    json['classifyName'] as String,
    json['numberOfListingView'] as int,
    json['ownerName'] as String,
    (json['lastCall'] as num)?.toDouble(),
    json['tour'] as int,
    json['listingTypeId'] as int,
    json['listingTypeName'] as String,
    json['propertyTypeId'] as int,
    json['propertyTypeName'] as String,
    (json['dealClassify'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$ListingToJson(Listing instance) => <String, dynamic>{
      'rlistingId': instance.rlistingId,
      'scorecardType': instance.scorecardType,
      'formatPrice': instance.formatPrice,
      'formatFloorSize': instance.formatFloorSize,
      'formatLotSize': instance.formatLotSize,
      'address': instance.address,
      'classify': instance.classify,
      'classifyName': instance.classifyName,
      'numberOfListingView': instance.numberOfListingView,
      'ownerName': instance.ownerName,
      'lastCall': instance.lastCall,
      'tour': instance.tour,
      'listingTypeId': instance.listingTypeId,
      'listingTypeName': instance.listingTypeName,
      'propertyTypeId': instance.propertyTypeId,
      'propertyTypeName': instance.propertyTypeName,
      'dealClassify': instance.dealClassify,
    };
