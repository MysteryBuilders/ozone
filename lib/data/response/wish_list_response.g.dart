// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerAttributeItemResponse _$CustomerAttributeItemResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerAttributeItemResponse(
      json['attribute_code'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$CustomerAttributeItemResponseToJson(
        CustomerAttributeItemResponse instance) =>
    <String, dynamic>{
      'attribute_code': instance.attributeCode,
      'value': instance.value,
    };

ProductItemResponse _$ProductItemResponseFromJson(Map<String, dynamic> json) =>
    ProductItemResponse(
      (json['id'] as num?)?.toInt(),
      json['sku'] as String?,
      json['name'] as String?,
      (json['attribute_set_id'] as num?)?.toInt(),
      (json['price'] as num?)?.toDouble(),
      (json['status'] as num?)?.toInt(),
      (json['visibility'] as num?)?.toInt(),
      json['type_id'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      (json['custom_attributes'] as List<dynamic>?)
          ?.map((e) =>
              CustomerAttributeItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductItemResponseToJson(
        ProductItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'attribute_set_id': instance.attributeSetId,
      'price': instance.price,
      'status': instance.status,
      'visibility': instance.visibility,
      'type_id': instance.typeId,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'custom_attributes': instance.customerAttributeList,
    };

WishListItemsResponse _$WishListItemsResponseFromJson(
        Map<String, dynamic> json) =>
    WishListItemsResponse(
      (json['id'] as num?)?.toInt(),
      (json['qty'] as num?)?.toInt(),
      json['product'] == null
          ? null
          : ProductItemResponse.fromJson(
              json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishListItemsResponseToJson(
        WishListItemsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'product': instance.productItemResponse,
    };

WishListResponse _$WishListResponseFromJson(Map<String, dynamic> json) =>
    WishListResponse(
      (json['customer_id'] as num?)?.toInt(),
      json['sharing_code'] as String?,
      (json['items_count'] as num?)?.toInt(),
      (json['items'] as List<dynamic>?)
          ?.map(
              (e) => WishListItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishListResponseToJson(WishListResponse instance) =>
    <String, dynamic>{
      'customer_id': instance.customer_id,
      'sharing_code': instance.sharing_code,
      'items_count': instance.items_count,
      'items': instance.wishList,
    };
