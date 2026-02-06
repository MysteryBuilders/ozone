// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      (json['id'] as num?)?.toInt(),
      json['email'] as String?,
      json['firstname'] as String?,
      json['lastname'] as String?,
      (json['store_id'] as num?)?.toInt(),
      (json['website_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'store_id': instance.storeId,
      'website_id': instance.websiteId,
    };
