// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      locationId: json['location_id'] as String?,
      visitorId: json['visitor_id'] as String?,
      customerId: json['customer_id'] as String?,
      quoteId: json['quote_id'] as String?,
      countryId: json['country_id'] as String?,
      regionId: json['region_id'] as String?,
      region: json['region'] as String?,
      websiteId: json['website_id'] as String?,
      sourceCode: json['source_code'] as String?,
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'visitor_id': instance.visitorId,
      'customer_id': instance.customerId,
      'quote_id': instance.quoteId,
      'country_id': instance.countryId,
      'region_id': instance.regionId,
      'region': instance.region,
      'website_id': instance.websiteId,
      'source_code': instance.sourceCode,
    };
