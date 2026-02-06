// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
      json['entity_id'] as String?,
      json['states_name'] as String?,
      json['cities_name'] as String?,
    );

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'entity_id': instance.entity_id,
      'states_name': instance.states_name,
      'cities_name': instance.cities_name,
    };
