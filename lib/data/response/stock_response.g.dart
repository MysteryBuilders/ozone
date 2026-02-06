// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockResponse _$StockResponseFromJson(Map<String, dynamic> json) =>
    StockResponse(
      (json['item_id'] as num?)?.toInt(),
      (json['product_id'] as num?)?.toInt(),
      (json['stock_id'] as num?)?.toInt(),
      json['is_in_stock'] as bool?,
      (json['min_sale_qty'] as num?)?.toInt(),
      (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StockResponseToJson(StockResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'product_id': instance.productId,
      'stock_id': instance.stockId,
      'is_in_stock': instance.isInStock,
      'min_sale_qty': instance.minSaleQty,
      'qty': instance.qty,
    };
