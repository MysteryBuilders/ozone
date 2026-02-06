// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutItemResponse _$CheckOutItemResponseFromJson(
        Map<String, dynamic> json) =>
    CheckOutItemResponse(
      itemId: (json['item_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      basePrce: (json['base_price'] as num?)?.toDouble(),
      qty: (json['qty'] as num?)?.toInt(),
      rowTotal: (json['row_total'] as num?)?.toDouble(),
      baseRowTotal: (json['base_row_total'] as num?)?.toDouble(),
      rowTotalWithDiscount:
          (json['row_total_with_discount'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      baseTaxAmount: (json['base_tax_amount'] as num?)?.toDouble(),
      taxPrecent: (json['tax_percent'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      baseDiscountAmount: (json['base_discount_amount'] as num?)?.toDouble(),
      discountPrecent: (json['discount_percent'] as num?)?.toDouble(),
      priceInclTax: (json['price_incl_tax'] as num?)?.toDouble(),
      basePriceInclTax: (json['base_price_incl_tax'] as num?)?.toDouble(),
      rowTotalInclTax: (json['row_total_incl_tax'] as num?)?.toDouble(),
      baseRowTotalInclTax:
          (json['base_row_total_incl_tax'] as num?)?.toDouble(),
      weeeTaxAppliedAmount: json['weee_tax_applied_amount'] as String?,
      weeeTaxApplied: json['weee_tax_applied'] as String?,
      name: json['name'] as String?,
      extenstionAttibutesResponse: json['extension_attributes'] == null
          ? null
          : ExtenstionAttibutesResponse.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckOutItemResponseToJson(
        CheckOutItemResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'price': instance.price,
      'base_price': instance.basePrce,
      'qty': instance.qty,
      'row_total': instance.rowTotal,
      'base_row_total': instance.baseRowTotal,
      'row_total_with_discount': instance.rowTotalWithDiscount,
      'tax_amount': instance.taxAmount,
      'base_tax_amount': instance.baseTaxAmount,
      'tax_percent': instance.taxPrecent,
      'discount_amount': instance.discountAmount,
      'base_discount_amount': instance.baseDiscountAmount,
      'discount_percent': instance.discountPrecent,
      'price_incl_tax': instance.priceInclTax,
      'row_total_incl_tax': instance.rowTotalInclTax,
      'base_price_incl_tax': instance.basePriceInclTax,
      'base_row_total_incl_tax': instance.baseRowTotalInclTax,
      'weee_tax_applied_amount': instance.weeeTaxAppliedAmount,
      'weee_tax_applied': instance.weeeTaxApplied,
      'name': instance.name,
      'extension_attributes': instance.extenstionAttibutesResponse?.toJson(),
    };

CheckOutResponse _$CheckOutResponseFromJson(Map<String, dynamic> json) =>
    CheckOutResponse(
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      baseGrandTotal: (json['base_grand_total'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      baseSubTotal: (json['base_subtotal'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      baseDiscountAmount: (json['base_discount_amount'] as num?)?.toDouble(),
      subTotalWithDiscount:
          (json['subtotal_with_discount'] as num?)?.toDouble(),
      basesubTotalWithDiscount:
          (json['base_subtotal_with_discount'] as num?)?.toDouble(),
      shippingAmount: (json['shipping_amount'] as num?)?.toDouble(),
      baseShippingAmount: (json['base_shipping_amount'] as num?)?.toDouble(),
      shippingDiscountAmount:
          (json['shipping_discount_amount'] as num?)?.toDouble(),
      baseshippingDiscountAmount:
          (json['base_shipping_discount_amount'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      baseTaxAmount: (json['base_tax_amount'] as num?)?.toDouble(),
      shippingTaxAmount: (json['shipping_tax_amount'] as num?)?.toDouble(),
      baseshippingTaxAmount:
          (json['base_shipping_tax_amount'] as num?)?.toDouble(),
      subTotalInclTax: (json['subtotal_incl_tax'] as num?)?.toDouble(),
      shippingInclTax: (json['shipping_incl_tax'] as num?)?.toDouble(),
      baseshippingInclTax: (json['base_shipping_incl_tax'] as num?)?.toDouble(),
      baseCurrencyCode: json['base_currency_code'] as String?,
      quoteCurrencyCode: json['quote_currency_code'] as String?,
      coupounCode: json['coupon_code'] as String?,
      itemsQty: (json['items_qty'] as num?)?.toInt(),
      list: (json['items'] as List<dynamic>?)
          ?.map((e) => CheckOutItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSegments: (json['total_segments'] as List<dynamic>?)
          ?.map(
              (e) => totalSegmentsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckOutResponseToJson(CheckOutResponse instance) =>
    <String, dynamic>{
      'grand_total': instance.grandTotal,
      'base_grand_total': instance.baseGrandTotal,
      'subtotal': instance.subtotal,
      'base_subtotal': instance.baseSubTotal,
      'discount_amount': instance.discountAmount,
      'base_discount_amount': instance.baseDiscountAmount,
      'subtotal_with_discount': instance.subTotalWithDiscount,
      'base_subtotal_with_discount': instance.basesubTotalWithDiscount,
      'shipping_amount': instance.shippingAmount,
      'base_shipping_amount': instance.baseShippingAmount,
      'shipping_discount_amount': instance.shippingDiscountAmount,
      'base_shipping_discount_amount': instance.baseshippingDiscountAmount,
      'tax_amount': instance.taxAmount,
      'base_tax_amount': instance.baseTaxAmount,
      'shipping_tax_amount': instance.shippingTaxAmount,
      'base_shipping_tax_amount': instance.baseshippingTaxAmount,
      'subtotal_incl_tax': instance.subTotalInclTax,
      'shipping_incl_tax': instance.shippingInclTax,
      'base_shipping_incl_tax': instance.baseshippingInclTax,
      'base_currency_code': instance.baseCurrencyCode,
      'quote_currency_code': instance.quoteCurrencyCode,
      'coupon_code': instance.coupounCode,
      'items_qty': instance.itemsQty,
      'items': instance.list?.map((e) => e.toJson()).toList(),
      'total_segments': instance.totalSegments?.map((e) => e.toJson()).toList(),
    };

totalSegmentsResponse _$totalSegmentsResponseFromJson(
        Map<String, dynamic> json) =>
    totalSegmentsResponse(
      code: json['code'] as String?,
      title: json['title'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$totalSegmentsResponseToJson(
        totalSegmentsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'value': instance.value,
    };

ExtenstionAttibutesResponse _$ExtenstionAttibutesResponseFromJson(
        Map<String, dynamic> json) =>
    ExtenstionAttibutesResponse(
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$ExtenstionAttibutesResponseToJson(
        ExtenstionAttibutesResponse instance) =>
    <String, dynamic>{
      'image_url': instance.image_url,
    };
