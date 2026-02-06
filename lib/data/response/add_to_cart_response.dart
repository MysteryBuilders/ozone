import 'package:json_annotation/json_annotation.dart';
part 'add_to_cart_response.g.dart';
@JsonSerializable(explicitToJson: true)
class AddToCartResponse {
  @JsonKey(name: 'item_id')
  int? itemId;
  @JsonKey(name: 'sku')
  String? sku;
  @JsonKey(name: 'qty')
  int? qty;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'product_type')
  String? productType;
  @JsonKey(name: 'quote_id')
  String? quoteId;
  @JsonKey(name: 'extension_attributes')
  ExtensionAttributesImage? extensionAttributesImage;
  AddToCartResponse({
    required this.itemId,
    this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    required this.quoteId,required this.extensionAttributesImage
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => _$AddToCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartResponseToJson(this);
}
@JsonSerializable(explicitToJson: true)
class ExtensionAttributesImage{
  @JsonKey(name: 'image_url')
  String? imageUrl;
  ExtensionAttributesImage({
    required this.imageUrl});
  factory ExtensionAttributesImage.fromJson(Map<String, dynamic> json) => _$ExtensionAttributesImageFromJson(json);
  Map<String, dynamic> toJson() => _$ExtensionAttributesImageToJson(this);

}