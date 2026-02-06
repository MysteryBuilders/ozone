import 'package:json_annotation/json_annotation.dart';
part 'add_to_wish_list_response.g.dart';
@JsonSerializable()
class AddToWishListResponse {
  @JsonKey(name:"success" )
  bool? success;
  @JsonKey(name:"message" )
  String? message;
  AddToWishListResponse(this.success,this.message);
  // from json

  factory AddToWishListResponse.fromJson(Map<String,dynamic> json) =>_$AddToWishListResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$AddToWishListResponseToJson(this);
}