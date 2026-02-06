// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_product_options_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleProductOptionsResponse _$BundleProductOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    BundleProductOptionsResponse(
      optionId: (json['option_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      required: json['required'] as bool?,
      type: json['type'] as String?,
      position: (json['position'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      productLinks: (json['product_links'] as List<dynamic>?)
          ?.map((e) => ProductLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleProductOptionsResponseToJson(
        BundleProductOptionsResponse instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'title': instance.title,
      'required': instance.required,
      'type': instance.type,
      'position': instance.position,
      'sku': instance.sku,
      'product_links': instance.productLinks,
    };

ProductLinks _$ProductLinksFromJson(Map<String, dynamic> json) => ProductLinks(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      optionId: (json['option_id'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      position: (json['position'] as num?)?.toInt(),
      isDefault: json['is_default'] as bool?,
      price: (json['price'] as num?)?.toInt(),
      priceType: (json['price_type'] as num?)?.toInt(),
      canChangeQuantity: (json['can_change_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductLinksToJson(ProductLinks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'option_id': instance.optionId,
      'qty': instance.qty,
      'position': instance.position,
      'is_default': instance.isDefault,
      'price': instance.price,
      'price_type': instance.priceType,
      'can_change_quantity': instance.canChangeQuantity,
    };
