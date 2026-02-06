import 'base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wish_list_response.g.dart';

@JsonSerializable()
class CustomerAttributeItemResponse {
  @JsonKey(name:"attribute_code" )
  String? attributeCode;
  @JsonKey(name:"value" )
  String? value;


  CustomerAttributeItemResponse(this.attributeCode,this.value);
  // from json

  factory CustomerAttributeItemResponse.fromJson(Map<String,dynamic> json) =>_$CustomerAttributeItemResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$CustomerAttributeItemResponseToJson(this);


}
@JsonSerializable()
class ProductItemResponse {
  @JsonKey(name:"id" )
  int? id;
  @JsonKey(name:"sku" )
  String? sku;
  @JsonKey(name:"name" )
  String? name;
  @JsonKey(name:"attribute_set_id" )
  int? attributeSetId;
  @JsonKey(name:"price" )
  double? price;
  @JsonKey(name:"status" )
  int? status;
  @JsonKey(name:"visibility" )
  int? visibility;
  @JsonKey(name:"type_id" )
  String? typeId;
  @JsonKey(name:"created_at" )
  String? created_at;
  @JsonKey(name:"updated_at" )
  String? updated_at;
  @JsonKey(name:"custom_attributes" )
  List<CustomerAttributeItemResponse>? customerAttributeList;
  ProductItemResponse(this.id,this.sku,this.name,this.attributeSetId,this.price,
      this.status,this.visibility,this.typeId,this.created_at,this.updated_at,this.customerAttributeList);
  // from json

  factory ProductItemResponse.fromJson(Map<String,dynamic> json) =>_$ProductItemResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$ProductItemResponseToJson(this);


}
@JsonSerializable()
class WishListItemsResponse {
@JsonKey(name:"id" )
int? id;
@JsonKey(name:"qty" )
int? qty;

@JsonKey(name:"product" )
ProductItemResponse? productItemResponse;

WishListItemsResponse(this.id,this.qty,this.productItemResponse);
factory WishListItemsResponse.fromJson(Map<String,dynamic> json) =>_$WishListItemsResponseFromJson(json);
// to json
Map<String,dynamic> toJson() => _$WishListItemsResponseToJson(this);


}
@JsonSerializable()
class WishListResponse {
  @JsonKey(name:"customer_id" )
  int? customer_id;
  @JsonKey(name:"sharing_code" )
  String? sharing_code;
  @JsonKey(name:"items_count" )
  int? items_count;
  @JsonKey(name:"items" )
  List<WishListItemsResponse>? wishList;

  WishListResponse(this.customer_id,this.sharing_code,this.items_count,this.wishList);
  factory WishListResponse.fromJson(Map<String,dynamic> json) =>_$WishListResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$WishListResponseToJson(this);


}