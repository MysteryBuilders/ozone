// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageExtension _$ImageExtensionFromJson(Map<String, dynamic> json) =>
    ImageExtension(
      product_image: json['product_image'] as String?,
    );

Map<String, dynamic> _$ImageExtensionToJson(ImageExtension instance) =>
    <String, dynamic>{
      'product_image': instance.product_image,
    };

ProductMyItemResponse _$ProductMyItemResponseFromJson(
        Map<String, dynamic> json) =>
    ProductMyItemResponse(
      amount_refunded: (json['amount_refunded'] as num?)?.toDouble(),
      base_amount_refunded: (json['base_amount_refunded'] as num?)?.toDouble(),
      base_cost: (json['base_cost'] as num?)?.toDouble(),
      base_discount_amount: (json['base_discount_amount'] as num?)?.toDouble(),
      base_discount_invoiced:
          (json['base_discount_invoiced'] as num?)?.toDouble(),
      base_discount_tax_compensation_amount:
          (json['base_discount_tax_compensation_amount'] as num?)?.toDouble(),
      base_original_price: (json['base_original_price'] as num?)?.toDouble(),
      base_price: (json['base_price'] as num?)?.toDouble(),
      base_price_incl_tax: (json['base_price_incl_tax'] as num?)?.toDouble(),
      base_row_invoiced: (json['base_row_invoiced'] as num?)?.toDouble(),
      base_row_total: (json['base_row_total'] as num?)?.toDouble(),
      base_row_total_incl_tax:
          (json['base_row_total_incl_tax'] as num?)?.toDouble(),
      base_tax_amount: (json['base_tax_amount'] as num?)?.toDouble(),
      base_tax_invoiced: (json['base_tax_invoiced'] as num?)?.toDouble(),
      created_at: json['created_at'] as String?,
      discount_amount: (json['discount_amount'] as num?)?.toDouble(),
      discount_invoiced: (json['discount_invoiced'] as num?)?.toDouble(),
      discount_percent: (json['discount_percent'] as num?)?.toDouble(),
      free_shipping: (json['free_shipping'] as num?)?.toDouble(),
      discount_tax_compensation_amount:
          (json['discount_tax_compensation_amount'] as num?)?.toDouble(),
      discount_tax_compensation_canceled:
          (json['discount_tax_compensation_canceled'] as num?)?.toDouble(),
      is_qty_decimal: (json['is_qty_decimal'] as num?)?.toDouble(),
      is_virtual: (json['is_virtual'] as num?)?.toDouble(),
      item_id: (json['item_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      no_discount: (json['no_discount'] as num?)?.toDouble(),
      order_id: (json['order_id'] as num?)?.toInt(),
      original_price: (json['original_price'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      price_incl_tax: (json['price_incl_tax'] as num?)?.toDouble(),
      product_id: (json['product_id'] as num?)?.toInt(),
      product_type: json['product_type'] as String?,
      qty_canceled: (json['qty_canceled'] as num?)?.toInt(),
      qty_invoiced: (json['qty_invoiced'] as num?)?.toInt(),
      qty_ordered: (json['qty_ordered'] as num?)?.toInt(),
      qty_refunded: (json['qty_refunded'] as num?)?.toInt(),
      qty_shipped: (json['qty_shipped'] as num?)?.toInt(),
      quote_item_id: (json['quote_item_id'] as num?)?.toInt(),
      row_invoiced: (json['row_invoiced'] as num?)?.toInt(),
      row_total: (json['row_total'] as num?)?.toDouble(),
      row_total_incl_tax: (json['row_total_incl_tax'] as num?)?.toDouble(),
      row_weight: (json['row_weight'] as num?)?.toDouble(),
      sku: json['sku'] as String?,
      store_id: (json['store_id'] as num?)?.toInt(),
      tax_amount: (json['tax_amount'] as num?)?.toDouble(),
      tax_canceled: (json['tax_canceled'] as num?)?.toDouble(),
      tax_invoiced: (json['tax_invoiced'] as num?)?.toDouble(),
      tax_percent: (json['tax_percent'] as num?)?.toDouble(),
      updated_at: json['updated_at'] as String?,
      imageExtension: json['extension_attributes'] == null
          ? null
          : ImageExtension.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductMyItemResponseToJson(
        ProductMyItemResponse instance) =>
    <String, dynamic>{
      'amount_refunded': instance.amount_refunded,
      'base_amount_refunded': instance.base_amount_refunded,
      'base_cost': instance.base_cost,
      'base_discount_amount': instance.base_discount_amount,
      'base_discount_invoiced': instance.base_discount_invoiced,
      'base_discount_tax_compensation_amount':
          instance.base_discount_tax_compensation_amount,
      'base_original_price': instance.base_original_price,
      'base_price': instance.base_price,
      'base_price_incl_tax': instance.base_price_incl_tax,
      'base_row_invoiced': instance.base_row_invoiced,
      'base_row_total': instance.base_row_total,
      'base_row_total_incl_tax': instance.base_row_total_incl_tax,
      'base_tax_amount': instance.base_tax_amount,
      'base_tax_invoiced': instance.base_tax_invoiced,
      'created_at': instance.created_at,
      'discount_amount': instance.discount_amount,
      'discount_invoiced': instance.discount_invoiced,
      'discount_percent': instance.discount_percent,
      'free_shipping': instance.free_shipping,
      'discount_tax_compensation_amount':
          instance.discount_tax_compensation_amount,
      'discount_tax_compensation_canceled':
          instance.discount_tax_compensation_canceled,
      'is_qty_decimal': instance.is_qty_decimal,
      'is_virtual': instance.is_virtual,
      'item_id': instance.item_id,
      'name': instance.name,
      'no_discount': instance.no_discount,
      'order_id': instance.order_id,
      'original_price': instance.original_price,
      'price': instance.price,
      'price_incl_tax': instance.price_incl_tax,
      'product_id': instance.product_id,
      'product_type': instance.product_type,
      'qty_canceled': instance.qty_canceled,
      'qty_invoiced': instance.qty_invoiced,
      'qty_ordered': instance.qty_ordered,
      'qty_refunded': instance.qty_refunded,
      'qty_shipped': instance.qty_shipped,
      'quote_item_id': instance.quote_item_id,
      'row_invoiced': instance.row_invoiced,
      'row_total': instance.row_total,
      'row_total_incl_tax': instance.row_total_incl_tax,
      'row_weight': instance.row_weight,
      'sku': instance.sku,
      'store_id': instance.store_id,
      'tax_amount': instance.tax_amount,
      'tax_canceled': instance.tax_canceled,
      'tax_invoiced': instance.tax_invoiced,
      'tax_percent': instance.tax_percent,
      'updated_at': instance.updated_at,
      'extension_attributes': instance.imageExtension,
    };

MyItemResponse _$MyItemResponseFromJson(Map<String, dynamic> json) =>
    MyItemResponse(
      order_id: (json['order_id'] as num?)?.toInt(),
      applied_rule_ids: json['applied_rule_ids'] as String?,
      base_currency_code: json['base_currency_code'] as String?,
      base_discount_amount: (json['base_discount_amount'] as num?)?.toDouble(),
      base_discount_canceled:
          (json['base_discount_canceled'] as num?)?.toDouble(),
      base_grand_total: (json['base_grand_total'] as num?)?.toDouble(),
      base_discount_tax_compensation_amount:
          (json['base_discount_tax_compensation_amount'] as num?)?.toDouble(),
      base_shipping_amount: (json['base_shipping_amount'] as num?)?.toDouble(),
      base_shipping_canceled:
          (json['base_shipping_canceled'] as num?)?.toDouble(),
      base_shipping_discount_amount:
          (json['base_shipping_discount_amount'] as num?)?.toDouble(),
      base_shipping_discount_tax_compensation_amnt:
          (json['base_shipping_discount_tax_compensation_amnt'] as num?)
              ?.toDouble(),
      base_shipping_incl_tax:
          (json['base_shipping_incl_tax'] as num?)?.toDouble(),
      base_shipping_tax_amount:
          (json['base_shipping_tax_amount'] as num?)?.toDouble(),
      base_subtotal: (json['base_subtotal'] as num?)?.toDouble(),
      base_tax_amount: (json['base_tax_amount'] as num?)?.toDouble(),
      base_tax_canceled: (json['base_tax_canceled'] as num?)?.toDouble(),
      base_total_canceled: (json['base_total_canceled'] as num?)?.toDouble(),
      base_total_due: (json['base_total_due'] as num?)?.toDouble(),
      base_to_global_rate: (json['base_to_global_rate'] as num?)?.toDouble(),
      discount_tax_compensation_amount:
          (json['discount_tax_compensation_amount'] as num?)?.toDouble(),
      base_to_order_rate: (json['base_to_order_rate'] as num?)?.toDouble(),
      billing_address_id: (json['billing_address_id'] as num?)?.toInt(),
      coupon_code: json['coupon_code'] as String?,
      created_at: json['created_at'] as String?,
      customer_email: json['customer_email'] as String?,
      customer_firstname: json['customer_firstname'] as String?,
      customer_group_id: (json['customer_group_id'] as num?)?.toInt(),
      customer_id: (json['customer_id'] as num?)?.toInt(),
      customer_is_guest: (json['customer_is_guest'] as num?)?.toInt(),
      customer_lastname: json['customer_lastname'] as String?,
      customer_note_notify: (json['customer_note_notify'] as num?)?.toInt(),
      discount_amount: (json['discount_amount'] as num?)?.toDouble(),
      discount_canceled: (json['discount_canceled'] as num?)?.toDouble(),
      discount_description: json['discount_description'] as String?,
      entity_id: (json['entity_id'] as num?)?.toInt(),
      global_currency_code: json['global_currency_code'] as String?,
      grand_total: (json['grand_total'] as num?)?.toDouble(),
      increment_id: json['increment_id'] as String?,
      is_virtual: (json['is_virtual'] as num?)?.toInt(),
      order_currency_code: json['order_currency_code'] as String?,
      protect_code: json['protect_code'] as String?,
      quote_id: (json['quote_id'] as num?)?.toInt(),
      remote_ip: json['remote_ip'] as String?,
      shipping_amount: (json['shipping_amount'] as num?)?.toDouble(),
      shipping_canceled: (json['shipping_canceled'] as num?)?.toDouble(),
      shipping_description: json['shipping_description'] as String?,
      shipping_discount_amount:
          (json['shipping_discount_amount'] as num?)?.toDouble(),
      shipping_discount_tax_compensation_amount:
          (json['shipping_discount_tax_compensation_amount'] as num?)
              ?.toDouble(),
      shipping_incl_tax: (json['shipping_incl_tax'] as num?)?.toDouble(),
      shipping_tax_amount: (json['shipping_tax_amount'] as num?)?.toDouble(),
      state: json['state'] as String?,
      status: json['status'] as String?,
      store_currency_code: json['store_currency_code'] as String?,
      store_id: (json['store_id'] as num?)?.toInt(),
      store_name: json['store_name'] as String?,
      store_to_base_rate: (json['store_to_base_rate'] as num?)?.toInt(),
      store_to_order_rate: (json['store_to_order_rate'] as num?)?.toInt(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      subtotal_canceled: (json['subtotal_canceled'] as num?)?.toDouble(),
      subtotal_incl_tax: (json['subtotal_incl_tax'] as num?)?.toDouble(),
      tax_amount: (json['tax_amount'] as num?)?.toDouble(),
      tax_canceled: (json['tax_canceled'] as num?)?.toDouble(),
      total_canceled: (json['total_canceled'] as num?)?.toDouble(),
      total_due: (json['total_due'] as num?)?.toDouble(),
      total_item_count: (json['total_item_count'] as num?)?.toInt(),
      total_qty_ordered: (json['total_qty_ordered'] as num?)?.toInt(),
      updated_at: json['updated_at'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      x_forwarded_for: json['x_forwarded_for'] as String?,
      products: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ProductMyItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      billingOrderAddressResponse: json['billing_address'] == null
          ? null
          : BillingOrderAddressResponse.fromJson(
              json['billing_address'] as Map<String, dynamic>),
      paymentOrderResponse: json['payment'] == null
          ? null
          : PaymentOrderResponse.fromJson(
              json['payment'] as Map<String, dynamic>),
      statusHistoryList: (json['status_histories'] as List<dynamic>?)
          ?.map((e) =>
              StatusHistoryOrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      extenstionAttributesOrderResponse: json['extension_attributes'] == null
          ? null
          : ExtenstionAttributesOrderResponse.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyItemResponseToJson(MyItemResponse instance) =>
    <String, dynamic>{
      'order_id': instance.order_id,
      'applied_rule_ids': instance.applied_rule_ids,
      'base_currency_code': instance.base_currency_code,
      'base_discount_amount': instance.base_discount_amount,
      'base_discount_canceled': instance.base_discount_canceled,
      'base_grand_total': instance.base_grand_total,
      'base_discount_tax_compensation_amount':
          instance.base_discount_tax_compensation_amount,
      'base_shipping_amount': instance.base_shipping_amount,
      'base_shipping_canceled': instance.base_shipping_canceled,
      'base_shipping_discount_amount': instance.base_shipping_discount_amount,
      'base_shipping_discount_tax_compensation_amnt':
          instance.base_shipping_discount_tax_compensation_amnt,
      'base_shipping_incl_tax': instance.base_shipping_incl_tax,
      'base_shipping_tax_amount': instance.base_shipping_tax_amount,
      'base_subtotal': instance.base_subtotal,
      'base_tax_amount': instance.base_tax_amount,
      'base_tax_canceled': instance.base_tax_canceled,
      'base_total_canceled': instance.base_total_canceled,
      'base_total_due': instance.base_total_due,
      'base_to_global_rate': instance.base_to_global_rate,
      'discount_tax_compensation_amount':
          instance.discount_tax_compensation_amount,
      'base_to_order_rate': instance.base_to_order_rate,
      'billing_address_id': instance.billing_address_id,
      'coupon_code': instance.coupon_code,
      'created_at': instance.created_at,
      'customer_email': instance.customer_email,
      'customer_firstname': instance.customer_firstname,
      'customer_group_id': instance.customer_group_id,
      'customer_id': instance.customer_id,
      'customer_is_guest': instance.customer_is_guest,
      'customer_lastname': instance.customer_lastname,
      'customer_note_notify': instance.customer_note_notify,
      'discount_amount': instance.discount_amount,
      'discount_canceled': instance.discount_canceled,
      'discount_description': instance.discount_description,
      'entity_id': instance.entity_id,
      'global_currency_code': instance.global_currency_code,
      'grand_total': instance.grand_total,
      'increment_id': instance.increment_id,
      'is_virtual': instance.is_virtual,
      'order_currency_code': instance.order_currency_code,
      'protect_code': instance.protect_code,
      'quote_id': instance.quote_id,
      'remote_ip': instance.remote_ip,
      'shipping_amount': instance.shipping_amount,
      'shipping_canceled': instance.shipping_canceled,
      'shipping_description': instance.shipping_description,
      'shipping_discount_amount': instance.shipping_discount_amount,
      'shipping_discount_tax_compensation_amount':
          instance.shipping_discount_tax_compensation_amount,
      'shipping_incl_tax': instance.shipping_incl_tax,
      'shipping_tax_amount': instance.shipping_tax_amount,
      'state': instance.state,
      'status': instance.status,
      'store_currency_code': instance.store_currency_code,
      'store_id': instance.store_id,
      'store_name': instance.store_name,
      'store_to_base_rate': instance.store_to_base_rate,
      'store_to_order_rate': instance.store_to_order_rate,
      'subtotal': instance.subtotal,
      'subtotal_canceled': instance.subtotal_canceled,
      'subtotal_incl_tax': instance.subtotal_incl_tax,
      'tax_amount': instance.tax_amount,
      'tax_canceled': instance.tax_canceled,
      'total_canceled': instance.total_canceled,
      'total_due': instance.total_due,
      'total_item_count': instance.total_item_count,
      'total_qty_ordered': instance.total_qty_ordered,
      'updated_at': instance.updated_at,
      'weight': instance.weight,
      'x_forwarded_for': instance.x_forwarded_for,
      'items': instance.products,
      'billing_address': instance.billingOrderAddressResponse,
      'payment': instance.paymentOrderResponse,
      'status_histories': instance.statusHistoryList,
      'extension_attributes': instance.extenstionAttributesOrderResponse,
    };

MyOrdersResponse _$MyOrdersResponseFromJson(Map<String, dynamic> json) =>
    MyOrdersResponse(
      orders: (json['items'] as List<dynamic>)
          .map((e) => MyItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOrdersResponseToJson(MyOrdersResponse instance) =>
    <String, dynamic>{
      'items': instance.orders,
    };

BillingOrderAddressResponse _$BillingOrderAddressResponseFromJson(
        Map<String, dynamic> json) =>
    BillingOrderAddressResponse(
      address_type: json['address_type'] as String?,
      city: json['city'] as String?,
      country_id: json['country_id'] as String?,
      email: json['email'] as String?,
      entity_id: (json['entity_id'] as num?)?.toInt(),
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      parent_id: (json['parent_id'] as num?)?.toInt(),
      postcode: json['postcode'] as String?,
      region: json['region'] as String?,
      region_code: json['region_code'] as String?,
      region_id: (json['region_id'] as num?)?.toInt(),
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      telephone: json['telephone'] as String?,
    )..customerId = (json['customer_id'] as num?)?.toInt();

Map<String, dynamic> _$BillingOrderAddressResponseToJson(
        BillingOrderAddressResponse instance) =>
    <String, dynamic>{
      'address_type': instance.address_type,
      'city': instance.city,
      'country_id': instance.country_id,
      'email': instance.email,
      'entity_id': instance.entity_id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'parent_id': instance.parent_id,
      'customer_id': instance.customerId,
      'postcode': instance.postcode,
      'region': instance.region,
      'region_code': instance.region_code,
      'region_id': instance.region_id,
      'street': instance.street,
      'telephone': instance.telephone,
    };

PaymentOrderResponse _$PaymentOrderResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentOrderResponse(
      account_status: json['account_status'] as String?,
      additional_information: json['additional_information'] as List<dynamic>?,
      amount_ordered: (json['amount_ordered'] as num?)?.toDouble(),
      base_amount_ordered: (json['base_amount_ordered'] as num?)?.toDouble(),
      base_shipping_amount: (json['base_shipping_amount'] as num?)?.toDouble(),
      cc_exp_year: json['cc_exp_year'] as String?,
      cc_last4: json['cc_last4'] as String?,
      cc_ss_start_month: json['cc_ss_start_month'] as String?,
      cc_ss_start_year: json['cc_ss_start_year'] as String?,
      entity_id: (json['entity_id'] as num?)?.toInt(),
      method: json['method'] as String?,
      parent_id: (json['parent_id'] as num?)?.toInt(),
      shipping_amount: (json['shipping_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PaymentOrderResponseToJson(
        PaymentOrderResponse instance) =>
    <String, dynamic>{
      'account_status': instance.account_status,
      'additional_information': instance.additional_information,
      'amount_ordered': instance.amount_ordered,
      'base_amount_ordered': instance.base_amount_ordered,
      'base_shipping_amount': instance.base_shipping_amount,
      'cc_exp_year': instance.cc_exp_year,
      'cc_last4': instance.cc_last4,
      'cc_ss_start_month': instance.cc_ss_start_month,
      'cc_ss_start_year': instance.cc_ss_start_year,
      'entity_id': instance.entity_id,
      'method': instance.method,
      'parent_id': instance.parent_id,
      'shipping_amount': instance.shipping_amount,
    };

StatusHistoryOrderResponse _$StatusHistoryOrderResponseFromJson(
        Map<String, dynamic> json) =>
    StatusHistoryOrderResponse(
      comment: json['comment'] as String?,
      created_at: json['created_at'] as String?,
      entity_id: (json['entity_id'] as num?)?.toInt(),
      entity_name: json['entity_name'] as String?,
      is_customer_notified: (json['is_customer_notified'] as num?)?.toInt(),
      is_visible_on_front: (json['is_visible_on_front'] as num?)?.toInt(),
      parent_id: (json['parent_id'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$StatusHistoryOrderResponseToJson(
        StatusHistoryOrderResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_at': instance.created_at,
      'entity_id': instance.entity_id,
      'entity_name': instance.entity_name,
      'is_customer_notified': instance.is_customer_notified,
      'is_visible_on_front': instance.is_visible_on_front,
      'parent_id': instance.parent_id,
      'status': instance.status,
    };

TotalShippingResponse _$TotalShippingResponseFromJson(
        Map<String, dynamic> json) =>
    TotalShippingResponse(
      base_shipping_amount: (json['base_shipping_amount'] as num?)?.toDouble(),
      base_shipping_canceled:
          (json['base_shipping_canceled'] as num?)?.toDouble(),
      base_shipping_discount_amount:
          (json['base_shipping_discount_amount'] as num?)?.toDouble(),
      base_shipping_discount_tax_compensation_amnt:
          (json['base_shipping_discount_tax_compensation_amnt'] as num?)
              ?.toDouble(),
      base_shipping_incl_tax:
          (json['base_shipping_incl_tax'] as num?)?.toDouble(),
      base_shipping_tax_amount:
          (json['base_shipping_tax_amount'] as num?)?.toDouble(),
      shipping_amount: (json['shipping_amount'] as num?)?.toDouble(),
      shipping_canceled: (json['shipping_canceled'] as num?)?.toDouble(),
      shipping_discount_amount:
          (json['shipping_discount_amount'] as num?)?.toDouble(),
      shipping_discount_tax_compensation_amount:
          (json['shipping_discount_tax_compensation_amount'] as num?)
              ?.toDouble(),
      shipping_incl_tax: (json['shipping_incl_tax'] as num?)?.toDouble(),
      shipping_tax_amount: (json['shipping_tax_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TotalShippingResponseToJson(
        TotalShippingResponse instance) =>
    <String, dynamic>{
      'base_shipping_amount': instance.base_shipping_amount,
      'base_shipping_canceled': instance.base_shipping_canceled,
      'base_shipping_discount_amount': instance.base_shipping_discount_amount,
      'base_shipping_discount_tax_compensation_amnt':
          instance.base_shipping_discount_tax_compensation_amnt,
      'base_shipping_incl_tax': instance.base_shipping_incl_tax,
      'base_shipping_tax_amount': instance.base_shipping_tax_amount,
      'shipping_amount': instance.shipping_amount,
      'shipping_canceled': instance.shipping_canceled,
      'shipping_discount_amount': instance.shipping_discount_amount,
      'shipping_discount_tax_compensation_amount':
          instance.shipping_discount_tax_compensation_amount,
      'shipping_incl_tax': instance.shipping_incl_tax,
      'shipping_tax_amount': instance.shipping_tax_amount,
    };

ShippingOrderResponse _$ShippingOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ShippingOrderResponse(
      json['address'] == null
          ? null
          : BillingOrderAddressResponse.fromJson(
              json['address'] as Map<String, dynamic>),
      json['method'] as String?,
      json['total'] == null
          ? null
          : TotalShippingResponse.fromJson(
              json['total'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShippingOrderResponseToJson(
        ShippingOrderResponse instance) =>
    <String, dynamic>{
      'address': instance.shippingOrderAddressResponse,
      'method': instance.method,
      'total': instance.totalShippingResponse,
    };

ShippingAssignmentOrderResponse _$ShippingAssignmentOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ShippingAssignmentOrderResponse(
      json['shipping'] == null
          ? null
          : ShippingOrderResponse.fromJson(
              json['shipping'] as Map<String, dynamic>),
      (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ProductMyItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShippingAssignmentOrderResponseToJson(
        ShippingAssignmentOrderResponse instance) =>
    <String, dynamic>{
      'shipping': instance.shippingOrderResponse,
      'items': instance.products,
    };

PaymentAdditionalInfoResponse _$PaymentAdditionalInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentAdditionalInfoResponse(
      json['key'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$PaymentAdditionalInfoResponseToJson(
        PaymentAdditionalInfoResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };

ExtenstionAttributesOrderResponse _$ExtenstionAttributesOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ExtenstionAttributesOrderResponse(
      (json['shipping_assignments'] as List<dynamic>?)
          ?.map((e) => ShippingAssignmentOrderResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['payment_additional_info'] as List<dynamic>?)
          ?.map((e) =>
              PaymentAdditionalInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtenstionAttributesOrderResponseToJson(
        ExtenstionAttributesOrderResponse instance) =>
    <String, dynamic>{
      'shipping_assignments': instance.shippingAssignmentList,
      'payment_additional_info': instance.paymentAdditionalList,
    };
