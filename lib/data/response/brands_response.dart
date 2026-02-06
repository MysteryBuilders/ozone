import 'package:json_annotation/json_annotation.dart';

part 'brands_response.g.dart';

String? _toString(dynamic value) => value?.toString();

@JsonSerializable(explicitToJson: true)
class BrandItemResponse {
  @JsonKey(name: 'brand_id')
  String? brand_id;
  @JsonKey(name: 'brand_name')
  String? brand_name;
  @JsonKey(name: 'brand_img')
  String? brand_img;
  @JsonKey(name: 'products_count')
  int? products_count;
  BrandItemResponse(this.brand_id,this.brand_name,this.brand_img,this.products_count);
  factory BrandItemResponse.fromJson(Map<String, dynamic> json) => _$BrandItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrandItemResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrandsDataResponse {
  @JsonKey(name: 'title', fromJson: _toString)
  String? title;
  @JsonKey(name: 'data')
  List<BrandItemResponse>? brandsList;
  BrandsDataResponse(this.title,this.brandsList);
  factory BrandsDataResponse.fromJson(Map<String, dynamic> json) => _$BrandsDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrandsDataResponseToJson(this);


}