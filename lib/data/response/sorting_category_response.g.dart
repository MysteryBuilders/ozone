// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortingOptionResponse _$SortingOptionResponseFromJson(
        Map<String, dynamic> json) =>
    SortingOptionResponse(
      json['sort_name'] as String?,
      json['sort_code'] as String?,
    );

Map<String, dynamic> _$SortingOptionResponseToJson(
        SortingOptionResponse instance) =>
    <String, dynamic>{
      'sort_name': instance.sortName,
      'sort_code': instance.sortCode,
    };

SortingCategoryResponse _$SortingCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    SortingCategoryResponse(
      (json['sorting_option'] as List<dynamic>?)
          ?.map(
              (e) => SortingOptionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['available_filter'] as List<dynamic>)
          .map((e) => AvailableFilter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SortingCategoryResponseToJson(
        SortingCategoryResponse instance) =>
    <String, dynamic>{
      'sorting_option': instance.sortList,
      'available_filter': instance.availableFilter,
    };

AvailableFilter _$AvailableFilterFromJson(Map<String, dynamic> json) =>
    AvailableFilter(
      filterName: json['filter_name'] as String,
      filterCode: json['filter_code'] as String,
      filterType: json['filter_type'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      minPrice: (json['min_price'] as num?)?.toInt(),
      maxPrice: (json['max_price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AvailableFilterToJson(AvailableFilter instance) =>
    <String, dynamic>{
      'filter_name': instance.filterName,
      'filter_code': instance.filterCode,
      'filter_type': instance.filterType,
      'options': instance.options,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };

FilterOption _$FilterOptionFromJson(Map<String, dynamic> json) => FilterOption(
      name: json['name'] as String,
      filterId: json['filter_id'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$FilterOptionToJson(FilterOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'filter_id': instance.filterId,
      'count': instance.count,
    };
