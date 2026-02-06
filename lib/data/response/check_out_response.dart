import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'check_out_response.g.dart';
@JsonSerializable(explicitToJson: true)
class CheckOutItemResponse {
  @JsonKey(name: 'item_id')
  int? itemId;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'base_price')
  double? basePrce;
  @JsonKey(name: 'qty')
  int? qty;
  @JsonKey(name: 'row_total')
  double? rowTotal;
  @JsonKey(name: 'base_row_total')
  double? baseRowTotal;
  @JsonKey(name: 'row_total_with_discount')
  double? rowTotalWithDiscount;
  @JsonKey(name: 'tax_amount')
  double? taxAmount;
  @JsonKey(name: 'base_tax_amount')
  double? baseTaxAmount;
  @JsonKey(name: 'tax_percent')
  double? taxPrecent;
  @JsonKey(name: 'discount_amount')
  double? discountAmount;
  @JsonKey(name: 'base_discount_amount')
  double? baseDiscountAmount;
  @JsonKey(name: 'discount_percent')
  double? discountPrecent;
  @JsonKey(name: 'price_incl_tax')
  double? priceInclTax;
  @JsonKey(name: 'row_total_incl_tax')
  double? rowTotalInclTax;
  @JsonKey(name: 'base_price_incl_tax')
  double? basePriceInclTax;
  @JsonKey(name: 'base_row_total_incl_tax')
  double? baseRowTotalInclTax;
  @JsonKey(name: 'weee_tax_applied_amount')
  String? weeeTaxAppliedAmount;
  @JsonKey(name: 'weee_tax_applied')
  String? weeeTaxApplied;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'extension_attributes')
  ExtenstionAttibutesResponse? extenstionAttibutesResponse;
  CheckOutItemResponse({
    required this.itemId,
   required this.price,
    required this.basePrce,
    required this.qty,
    required this.rowTotal,
    required this.baseRowTotal,
    required this.rowTotalWithDiscount,

    required this.taxAmount,
    required this.baseTaxAmount,
    required this.taxPrecent,
    required this.discountAmount,
    required this.baseDiscountAmount,
    required this.discountPrecent,
    required this.priceInclTax,
    required this.basePriceInclTax,
    required this.rowTotalInclTax,
    required this.baseRowTotalInclTax,



    required this.weeeTaxAppliedAmount,
    required this.weeeTaxApplied,
    required this.name,
    this.extenstionAttibutesResponse


  });

  factory CheckOutItemResponse.fromJson(Map<String, dynamic> json) => _$CheckOutItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutItemResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class CheckOutResponse {

  @JsonKey(name: 'grand_total')
  double? grandTotal;
  @JsonKey(name: 'base_grand_total')
  double? baseGrandTotal;
  @JsonKey(name: 'subtotal')
  double? subtotal;
  @JsonKey(name: 'base_subtotal')
  double? baseSubTotal;
  @JsonKey(name: 'discount_amount')
  double? discountAmount;
  @JsonKey(name: 'base_discount_amount')
  double? baseDiscountAmount;
  @JsonKey(name: 'subtotal_with_discount')
  double? subTotalWithDiscount;
  @JsonKey(name: 'base_subtotal_with_discount')
  double? basesubTotalWithDiscount;
  @JsonKey(name: 'shipping_amount')
  double? shippingAmount;
  @JsonKey(name: 'base_shipping_amount')
  double? baseShippingAmount;
  @JsonKey(name: 'shipping_discount_amount')
  double? shippingDiscountAmount;
  @JsonKey(name: 'base_shipping_discount_amount')
  double? baseshippingDiscountAmount;
  @JsonKey(name: 'tax_amount')
  double? taxAmount;
  @JsonKey(name: 'base_tax_amount')
  double? baseTaxAmount;
  @JsonKey(name: 'shipping_tax_amount')
  double? shippingTaxAmount;
  @JsonKey(name: 'base_shipping_tax_amount')
  double? baseshippingTaxAmount;
  @JsonKey(name: 'subtotal_incl_tax')
  double? subTotalInclTax;
  @JsonKey(name: 'shipping_incl_tax')
  double? shippingInclTax;
  @JsonKey(name: 'base_shipping_incl_tax')
  double? baseshippingInclTax;

  @JsonKey(name: 'base_currency_code')
  String? baseCurrencyCode;
  @JsonKey(name: 'quote_currency_code')
  String? quoteCurrencyCode;
  @JsonKey(name: 'coupon_code')
  String? coupounCode;
  @JsonKey(name: 'items_qty')
  int? itemsQty;
  @JsonKey(name: 'items')
  List<CheckOutItemResponse>? list;
  @JsonKey(name: 'total_segments')
  List<totalSegmentsResponse>? totalSegments;

  CheckOutResponse({
    required this.grandTotal,
    required this.baseGrandTotal,
    required this.subtotal,
    required this.baseSubTotal,
    required this.discountAmount,
    required this.baseDiscountAmount,
    required this.subTotalWithDiscount,

    required this.basesubTotalWithDiscount,
    required this.shippingAmount,
    required this.baseShippingAmount,
    required this.shippingDiscountAmount,
    required this.baseshippingDiscountAmount,
    required this.taxAmount,
    required this.baseTaxAmount,
    required this.shippingTaxAmount,
    required this.baseshippingTaxAmount,
    required this.subTotalInclTax,
    required this.shippingInclTax,
    required this.baseshippingInclTax,
    required this.baseCurrencyCode,
    required this.quoteCurrencyCode,
    required this.coupounCode,
    required this.itemsQty,

    required this.list,
    required this.totalSegments



  });

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) => _$CheckOutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutResponseToJson(this);
}
@JsonSerializable(explicitToJson: true)
class totalSegmentsResponse{
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'value')
  double? value;
  totalSegmentsResponse({required this.code,required this.title,required this.value});
  factory totalSegmentsResponse.fromJson(Map<String, dynamic> json) => _$totalSegmentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$totalSegmentsResponseToJson(this);

}

@JsonSerializable(explicitToJson: true)
class ExtenstionAttibutesResponse{
  @JsonKey(name: 'image_url')
  String? image_url;

  ExtenstionAttibutesResponse({required this.image_url});
  factory ExtenstionAttibutesResponse.fromJson(Map<String, dynamic> json) => _$ExtenstionAttibutesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtenstionAttibutesResponseToJson(this);

}
