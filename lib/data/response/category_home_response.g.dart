// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryHomeResponse _$CategoryHomeResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryHomeResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      searchCriteria: SearchCriteria.fromJson(
          json['search_criteria'] as Map<String, dynamic>),
      totalCount: (json['total_count'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryHomeResponseToJson(
        CategoryHomeResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'search_criteria': instance.searchCriteria,
      'total_count': instance.totalCount,
    };

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) => CategoryItem(
      categoryId: json['category_id'] as String,
      categoryImage: json['category_image'] as String,
    );

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_image': instance.categoryImage,
    };

SearchCriteria _$SearchCriteriaFromJson(Map<String, dynamic> json) =>
    SearchCriteria(
      filterGroups: json['filter_groups'] as List<dynamic>,
      pageSize: (json['page_size'] as num).toInt(),
    );

Map<String, dynamic> _$SearchCriteriaToJson(SearchCriteria instance) =>
    <String, dynamic>{
      'filter_groups': instance.filterGroups,
      'page_size': instance.pageSize,
    };
