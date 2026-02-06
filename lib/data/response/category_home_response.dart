import 'package:json_annotation/json_annotation.dart';

part 'category_home_response.g.dart';

@JsonSerializable()
class CategoryHomeResponse {
  final List<CategoryItem> items;
  @JsonKey(name: 'search_criteria')
  final SearchCriteria searchCriteria;
  @JsonKey(name: 'total_count')
  final int totalCount;

  CategoryHomeResponse({
    required this.items,
    required this.searchCriteria,
    required this.totalCount,
  });

  factory CategoryHomeResponse.fromJson(Map<String, dynamic> json) => _$CategoryHomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryHomeResponseToJson(this);
}

@JsonSerializable()
class CategoryItem {
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'category_image')
  final String categoryImage;

  CategoryItem({
    required this.categoryId,
    required this.categoryImage,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => _$CategoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}

@JsonSerializable()
class SearchCriteria {
  @JsonKey(name: 'filter_groups')
  final List<dynamic> filterGroups;
  @JsonKey(name: 'page_size')
  final int pageSize;

  SearchCriteria({
    required this.filterGroups,
    required this.pageSize,
  });

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => _$SearchCriteriaFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCriteriaToJson(this);
}
