import 'package:json_annotation/json_annotation.dart';
part 'sorting_category_response.g.dart';
@JsonSerializable()
class SortingOptionResponse {
  @JsonKey(name:"sort_name" )
  String? sortName;
  @JsonKey(name:"sort_code" )
  String? sortCode;
  SortingOptionResponse(this.sortName,this.sortCode);
  // from json

  factory SortingOptionResponse.fromJson(Map<String,dynamic> json) =>_$SortingOptionResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$SortingOptionResponseToJson(this);
}
@JsonSerializable()
class SortingCategoryResponse {
  @JsonKey(name:"sorting_option" )
  List<SortingOptionResponse>? sortList;
  @JsonKey(name: 'available_filter')
  final List<AvailableFilter> availableFilter;

  SortingCategoryResponse(this.sortList,this.availableFilter);
  // from json

  factory SortingCategoryResponse.fromJson(Map<String,dynamic> json) =>_$SortingCategoryResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$SortingCategoryResponseToJson(this);
}
@JsonSerializable()
class AvailableFilter {
  @JsonKey(name: 'filter_name')
  final String filterName;

  @JsonKey(name: 'filter_code')
  final String filterCode;

  @JsonKey(name: 'filter_type')
  final String filterType;

  final List<FilterOption>? options;

  @JsonKey(name: 'min_price')
  final int? minPrice;

  @JsonKey(name: 'max_price')
  final int? maxPrice;

  AvailableFilter({
    required this.filterName,
    required this.filterCode,
    required this.filterType,
    this.options,
    this.minPrice,
    this.maxPrice,
  });

  factory AvailableFilter.fromJson(Map<String, dynamic> json) => _$AvailableFilterFromJson(json);
  Map<String, dynamic> toJson() => _$AvailableFilterToJson(this);
}
@JsonSerializable()
class FilterOption {
  final String name;

  @JsonKey(name: 'filter_id')
  final String filterId;

  final int count;

  FilterOption({
    required this.name,
    required this.filterId,
    required this.count,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) => _$FilterOptionFromJson(json);
  Map<String, dynamic> toJson() => _$FilterOptionToJson(this);
}

