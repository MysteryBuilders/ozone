import 'package:json_annotation/json_annotation.dart';
part 'remove_wish_list_response.g.dart';
@JsonSerializable()
class RemoveWishListResponse {
  @JsonKey(name:"success" )
  bool? success;
  @JsonKey(name:"message" )
  String? message;
  RemoveWishListResponse(this.success,this.message);
  // from json

  factory RemoveWishListResponse.fromJson(Map<String,dynamic> json) =>_$RemoveWishListResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$RemoveWishListResponseToJson(this);
}