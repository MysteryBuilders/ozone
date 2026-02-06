// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_locator_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StareLocatorResponse _$StareLocatorResponseFromJson(
        Map<String, dynamic> json) =>
    StareLocatorResponse(
      json['store_code'] as String?,
      (json['website_id'] as num?)?.toInt(),
      json['source_code'] as String?,
    );

Map<String, dynamic> _$StareLocatorResponseToJson(
        StareLocatorResponse instance) =>
    <String, dynamic>{
      'store_code': instance.storeCode,
      'website_id': instance.webSiteId,
      'source_code': instance.sourceCode,
    };
