// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      (json['id'] as num?)?.toInt(),
      (json['group_id'] as num?)?.toInt(),
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['created_in'] as String?,
      json['email'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      (json['store_id'] as num?)?.toInt(),
      (json['website_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.group_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'created_in': instance.created_in,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'store_id': instance.store_id,
      'website_id': instance.website_id,
    };
