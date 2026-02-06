// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionResultResponse _$VersionResultResponseFromJson(
        Map<String, dynamic> json) =>
    VersionResultResponse(
      (json['ios'] as num?)?.toInt(),
      (json['android'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VersionResultResponseToJson(
        VersionResultResponse instance) =>
    <String, dynamic>{
      'ios': instance.ios,
      'android': instance.android,
    };

VersionDataResponse _$VersionDataResponseFromJson(Map<String, dynamic> json) =>
    VersionDataResponse(
      json['versions'] == null
          ? null
          : VersionResultResponse.fromJson(
              json['versions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VersionDataResponseToJson(
        VersionDataResponse instance) =>
    <String, dynamic>{
      'versions': instance.versionResultResponse,
    };

VersionResponse _$VersionResponseFromJson(Map<String, dynamic> json) =>
    VersionResponse(
      json['data'] == null
          ? null
          : VersionDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..isOk = json['ok'] as bool?
      ..error = json['error'] as String?
      ..status = json['status'] as String?;

Map<String, dynamic> _$VersionResponseToJson(VersionResponse instance) =>
    <String, dynamic>{
      'ok': instance.isOk,
      'error': instance.error,
      'status': instance.status,
      'data': instance.versionDataResponse,
    };
