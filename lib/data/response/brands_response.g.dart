// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandItemResponse _$BrandItemResponseFromJson(Map<String, dynamic> json) =>
    BrandItemResponse(
      json['brand_id'] as String?,
      json['brand_name'] as String?,
      json['brand_img'] as String?,
      (json['products_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BrandItemResponseToJson(BrandItemResponse instance) =>
    <String, dynamic>{
      'brand_id': instance.brand_id,
      'brand_name': instance.brand_name,
      'brand_img': instance.brand_img,
      'products_count': instance.products_count,
    };

BrandsDataResponse _$BrandsDataResponseFromJson(Map<String, dynamic> json) =>
    BrandsDataResponse(
      _toString(json['title']),
      (json['data'] as List<dynamic>?)
          ?.map((e) => BrandItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandsDataResponseToJson(BrandsDataResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'data': instance.brandsList?.map((e) => e.toJson()).toList(),
    };
