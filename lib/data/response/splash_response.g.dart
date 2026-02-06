// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSplashResponse _$ImageSplashResponseFromJson(Map<String, dynamic> json) =>
    ImageSplashResponse(
      json['image_url'] as String?,
      json['type'] as String?,
      json['id'] as String?,
    );

Map<String, dynamic> _$ImageSplashResponseToJson(
        ImageSplashResponse instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'type': instance.type,
      'id': instance.id,
    };

SplashResponse _$SplashResponseFromJson(Map<String, dynamic> json) =>
    SplashResponse(
      json['gif'] as String?,
      (json['timeout'] as num?)?.toInt(),
      (json['images'] as List<dynamic>)
          .map((e) => ImageSplashResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SplashResponseToJson(SplashResponse instance) =>
    <String, dynamic>{
      'gif': instance.gif,
      'timeout': instance.timeout,
      'images': instance.imageSplashList,
    };
