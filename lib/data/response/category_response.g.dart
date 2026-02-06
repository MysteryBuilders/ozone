// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: (json['id'] as num?)?.toInt(),
      parentId: (json['parent_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool?,
      position: (json['position'] as num).toInt(),
      level: (json['level'] as num?)?.toInt(),
      productCount: (json['product_count'] as num?)?.toInt(),
      childrenData: (json['children_data'] as List<dynamic>)
          .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'name': instance.name,
      'image': instance.image,
      'is_active': instance.isActive,
      'position': instance.position,
      'level': instance.level,
      'product_count': instance.productCount,
      'children_data': instance.childrenData.map((e) => e.toJson()).toList(),
    };
