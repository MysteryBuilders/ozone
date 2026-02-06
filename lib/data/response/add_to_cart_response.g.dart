// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartResponse _$AddToCartResponseFromJson(Map<String, dynamic> json) =>
    AddToCartResponse(
      itemId: (json['item_id'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      productType: json['product_type'] as String?,
      quoteId: json['quote_id'] as String?,
      extensionAttributesImage: json['extension_attributes'] == null
          ? null
          : ExtensionAttributesImage.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddToCartResponseToJson(AddToCartResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'sku': instance.sku,
      'qty': instance.qty,
      'name': instance.name,
      'price': instance.price,
      'product_type': instance.productType,
      'quote_id': instance.quoteId,
      'extension_attributes': instance.extensionAttributesImage?.toJson(),
    };

ExtensionAttributesImage _$ExtensionAttributesImageFromJson(
        Map<String, dynamic> json) =>
    ExtensionAttributesImage(
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ExtensionAttributesImageToJson(
        ExtensionAttributesImage instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
    };
