 import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'parent_id')
  int? parentId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'position')
  int position;
  @JsonKey(name: 'level')
  int? level;
  @JsonKey(name: 'product_count')
  int? productCount;
  @JsonKey(name: 'children_data')
  List<CategoryResponse> childrenData;

  CategoryResponse({
    required this.id,
    this.parentId,
    required this.name,
    required this.image,
    required this.isActive,
    required this.position,
    required this.level,
    required this.productCount,
    required this.childrenData,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
