// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionDataResponse _$AppVersionDataResponseFromJson(
        Map<String, dynamic> json) =>
    AppVersionDataResponse(
      versionId: json['version_id'] as String,
      ios: (json['ios'] as num).toInt(),
      andriod: (json['andriod'] as num).toInt(),
    );

Map<String, dynamic> _$AppVersionDataResponseToJson(
        AppVersionDataResponse instance) =>
    <String, dynamic>{
      'version_id': instance.versionId,
      'ios': instance.ios,
      'andriod': instance.andriod,
    };

AppVersionResponse _$AppVersionResponseFromJson(Map<String, dynamic> json) =>
    AppVersionResponse(
      versions: (json['items'] as List<dynamic>)
          .map(
              (e) => AppVersionDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppVersionResponseToJson(AppVersionResponse instance) =>
    <String, dynamic>{
      'items': instance.versions.map((e) => e.toJson()).toList(),
    };
