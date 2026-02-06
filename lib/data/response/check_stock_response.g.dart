// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCheckStockResponse _$ItemCheckStockResponseFromJson(
        Map<String, dynamic> json) =>
    ItemCheckStockResponse(
      json['sku'] as String?,
      json['source_code'] as String?,
      (json['quantity'] as num?)?.toInt(),
      (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemCheckStockResponseToJson(
        ItemCheckStockResponse instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'source_code': instance.sourceCode,
      'quantity': instance.quantity,
      'status': instance.status,
    };

CheckStockResponse _$CheckStockResponseFromJson(Map<String, dynamic> json) =>
    CheckStockResponse(
      (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ItemCheckStockResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckStockResponseToJson(CheckStockResponse instance) =>
    <String, dynamic>{
      'items': instance.list,
    };
