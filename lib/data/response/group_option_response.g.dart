// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_option_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupOptionResponse _$GroupOptionResponseFromJson(Map<String, dynamic> json) =>
    GroupOptionResponse(
      sku: json['sku'] as String?,
      linkType: json['link_type'] as String?,
      linkedProductSku: json['linked_product_sku'] as String?,
      linkedProductType: json['linked_product_type'] as String?,
      position: (json['position'] as num?)?.toInt(),
      extensionAttributes: json['extension_attributes'] == null
          ? null
          : ExtensionAttributes.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupOptionResponseToJson(
        GroupOptionResponse instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'link_type': instance.linkType,
      'linked_product_sku': instance.linkedProductSku,
      'linked_product_type': instance.linkedProductType,
      'position': instance.position,
      'extension_attributes': instance.extensionAttributes,
    };

ExtensionAttributes _$ExtensionAttributesFromJson(Map<String, dynamic> json) =>
    ExtensionAttributes(
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtensionAttributesToJson(
        ExtensionAttributes instance) =>
    <String, dynamic>{
      'qty': instance.qty,
    };
