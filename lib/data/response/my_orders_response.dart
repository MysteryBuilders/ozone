import 'package:json_annotation/json_annotation.dart';

part 'my_orders_response.g.dart';
@JsonSerializable()
class ImageExtension{
  @JsonKey(name: 'product_image')
  final String? product_image;
  ImageExtension({this.product_image});
  factory ImageExtension.fromJson(Map<String, dynamic> json) => _$ImageExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$ImageExtensionToJson(this);
}
// Root model
@JsonSerializable()
class ProductMyItemResponse {
  @JsonKey(name: 'amount_refunded')
  final double? amount_refunded;

  @JsonKey(name: 'base_amount_refunded')
  final double? base_amount_refunded;

  @JsonKey(name: 'base_cost')
  final double? base_cost;

  @JsonKey(name: 'base_discount_amount')
  final double? base_discount_amount;

  @JsonKey(name: 'base_discount_invoiced')
  final double? base_discount_invoiced;

  @JsonKey(name: 'base_discount_tax_compensation_amount')
  final double? base_discount_tax_compensation_amount;


  @JsonKey(name: 'base_original_price')
  final double? base_original_price;

  @JsonKey(name: 'base_price')
  final double? base_price;

  @JsonKey(name: 'base_price_incl_tax')
  final double? base_price_incl_tax;

  @JsonKey(name: 'base_row_invoiced')
  final double? base_row_invoiced;

  @JsonKey(name: 'base_row_total')
  final double? base_row_total;

  @JsonKey(name: 'base_row_total_incl_tax')
  final double? base_row_total_incl_tax;


  @JsonKey(name: 'base_tax_amount')
  final double? base_tax_amount;

  @JsonKey(name: 'base_tax_invoiced')
  final double? base_tax_invoiced;

  @JsonKey(name: 'created_at')
  final String? created_at;

  @JsonKey(name: 'discount_amount')
  final double? discount_amount;

  @JsonKey(name: 'discount_invoiced')
  final double? discount_invoiced;

  @JsonKey(name: 'discount_percent')
  final double? discount_percent;


  @JsonKey(name: 'free_shipping')
  final double? free_shipping;

  @JsonKey(name: 'discount_tax_compensation_amount')
  final double? discount_tax_compensation_amount;

  @JsonKey(name: 'discount_tax_compensation_canceled')
  final double? discount_tax_compensation_canceled;

  @JsonKey(name: 'is_qty_decimal')
  final double? is_qty_decimal;

  @JsonKey(name: 'is_virtual')
  final double? is_virtual;

  @JsonKey(name: 'item_id')
  final int? item_id;



  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'no_discount')
  final double? no_discount;

  @JsonKey(name: 'order_id')
  final int? order_id;

  @JsonKey(name: 'original_price')
  final double? original_price;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'price_incl_tax')
  final double? price_incl_tax;


  @JsonKey(name: 'product_id')
  final int? product_id;

  @JsonKey(name: 'product_type')
  final String? product_type;

  @JsonKey(name: 'qty_canceled')
  final int? qty_canceled;

  @JsonKey(name: 'qty_invoiced')
  final int? qty_invoiced;

  @JsonKey(name: 'qty_ordered')
  final int? qty_ordered;

  @JsonKey(name: 'qty_refunded')
  final int? qty_refunded;


  @JsonKey(name: 'qty_shipped')
  final int? qty_shipped;

  @JsonKey(name: 'quote_item_id')
  final int? quote_item_id;

  @JsonKey(name: 'row_invoiced')
  final int? row_invoiced;

  @JsonKey(name: 'row_total')
  final double? row_total;

  @JsonKey(name: 'row_total_incl_tax')
  final double? row_total_incl_tax;

  @JsonKey(name: 'row_weight')
  final double? row_weight;


  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'store_id')
  final int? store_id;

  @JsonKey(name: 'tax_amount')
  final double? tax_amount;

  @JsonKey(name: 'tax_canceled')
  final double? tax_canceled;

  @JsonKey(name: 'tax_invoiced')
  final double? tax_invoiced;

  @JsonKey(name: 'tax_percent')
  final double? tax_percent;

  @JsonKey(name: 'updated_at')
  final String? updated_at;
  @JsonKey(name: 'extension_attributes')
  final ImageExtension? imageExtension;

  ProductMyItemResponse({
    this.amount_refunded, 
    this.base_amount_refunded, 
    this.base_cost,
    this.base_discount_amount, 
    this.base_discount_invoiced, 
    this.base_discount_tax_compensation_amount,
    this.base_original_price, 
    this.base_price, 
    this.base_price_incl_tax,
    this.base_row_invoiced, 
    this.base_row_total, 
    this.base_row_total_incl_tax,
    this.base_tax_amount, 
    this.base_tax_invoiced, 
    this.created_at,
    this.discount_amount, 
    this.discount_invoiced, 
    this.discount_percent,
    this.free_shipping, 
    this.discount_tax_compensation_amount, 
    this.discount_tax_compensation_canceled,
    this.is_qty_decimal, 
    this.is_virtual, 
    this.item_id,
    this.name, 
    this.no_discount, 
    this.order_id,
    this.original_price, 
    this.price, 
    this.price_incl_tax,
    this.product_id, 
    this.product_type, 
    this.qty_canceled,
    this.qty_invoiced, 
    this.qty_ordered, 
    this.qty_refunded,
    this.qty_shipped, 
    this.quote_item_id, 
    this.row_invoiced,
    this.row_total, 
    this.row_total_incl_tax, 
    this.row_weight,
    this.sku, 
    this.store_id, 
    this.tax_amount,
    this.tax_canceled, 
    this.tax_invoiced, 
    this.tax_percent,
    this.updated_at,
    this.imageExtension
  });

  factory ProductMyItemResponse.fromJson(Map<String, dynamic> json) => _$ProductMyItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductMyItemResponseToJson(this);
}


@JsonSerializable()
class MyItemResponse {

  @JsonKey(name: 'order_id')
  final int? order_id;
  @JsonKey(name: 'applied_rule_ids')
  final String? applied_rule_ids;

  @JsonKey(name: 'base_currency_code')
  final String? base_currency_code;

  @JsonKey(name: 'base_discount_amount')
  final double? base_discount_amount;

  @JsonKey(name: 'base_discount_canceled')
  final double ?base_discount_canceled;

  @JsonKey(name: 'base_grand_total')
  final double? base_grand_total;

  @JsonKey(name: 'base_discount_tax_compensation_amount')
  final double? base_discount_tax_compensation_amount;


  @JsonKey(name: 'base_shipping_amount')
  final double? base_shipping_amount;

  @JsonKey(name: 'base_shipping_canceled')
  final double? base_shipping_canceled;

  @JsonKey(name: 'base_shipping_discount_amount')
  final double? base_shipping_discount_amount;

  @JsonKey(name: 'base_shipping_discount_tax_compensation_amnt')
  final double? base_shipping_discount_tax_compensation_amnt;

  @JsonKey(name: 'base_shipping_incl_tax')
  final double? base_shipping_incl_tax;




  @JsonKey(name: 'base_shipping_tax_amount')
  final double ?base_shipping_tax_amount;

  @JsonKey(name: 'base_subtotal')
  final double ?base_subtotal;

  @JsonKey(name: 'base_tax_amount')
  final double ?base_tax_amount;

  @JsonKey(name: 'base_tax_canceled')
  final double ?base_tax_canceled;

  @JsonKey(name: 'base_total_canceled')
  final double ?base_total_canceled;

  @JsonKey(name: 'base_total_due')
  final double? base_total_due;


  @JsonKey(name: 'base_to_global_rate')
  final double? base_to_global_rate;

  @JsonKey(name: 'discount_tax_compensation_amount')
  final double ?discount_tax_compensation_amount;

  @JsonKey(name: 'base_to_order_rate')
  final double? base_to_order_rate;

  @JsonKey(name: 'billing_address_id')
  final int ?billing_address_id;

  @JsonKey(name: 'coupon_code')
  final String ?coupon_code;

  @JsonKey(name: 'created_at')
  final String ?created_at;



  @JsonKey(name: 'customer_email')
  final String? customer_email;

  @JsonKey(name: 'customer_firstname')
  final String? customer_firstname;

  @JsonKey(name: 'customer_group_id')
  final int? customer_group_id;

  @JsonKey(name: 'customer_id')
  final int ?customer_id;

  @JsonKey(name: 'customer_is_guest')
  final int? customer_is_guest;

  @JsonKey(name: 'customer_lastname')
  final String? customer_lastname;


  @JsonKey(name: 'customer_note_notify')
  final int? customer_note_notify;

  @JsonKey(name: 'discount_amount')
  final double? discount_amount;

  @JsonKey(name: 'discount_canceled')
  final double? discount_canceled;

  @JsonKey(name: 'discount_description')
  final String ?discount_description;

  @JsonKey(name: 'entity_id')
  final int ?entity_id;

  @JsonKey(name: 'global_currency_code')
  final String ?global_currency_code;


  @JsonKey(name: 'grand_total')
  final double? grand_total;

  @JsonKey(name: 'increment_id')
  final String ?increment_id;

  @JsonKey(name: 'is_virtual')
  final int? is_virtual;

  @JsonKey(name: 'order_currency_code')
  final String? order_currency_code;

  @JsonKey(name: 'protect_code')
  final String ?protect_code;

  @JsonKey(name: 'quote_id')
  final int? quote_id;


  @JsonKey(name: 'remote_ip')
  final String ?remote_ip;

  @JsonKey(name: 'shipping_amount')
  final double? shipping_amount;

  @JsonKey(name: 'shipping_canceled')
  final double? shipping_canceled;

  @JsonKey(name: 'shipping_description')
  final String? shipping_description;

  @JsonKey(name: 'shipping_discount_amount')
  final double? shipping_discount_amount;

  @JsonKey(name: 'shipping_discount_tax_compensation_amount')
  final double? shipping_discount_tax_compensation_amount;

  @JsonKey(name: 'shipping_incl_tax')
  final double ?shipping_incl_tax;


  @JsonKey(name: 'shipping_tax_amount')
  final double? shipping_tax_amount;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'status')
  final String ?status;

  @JsonKey(name: 'store_currency_code')
  final String? store_currency_code;

  @JsonKey(name: 'store_id')
  final int? store_id;

  @JsonKey(name: 'store_name')
  final String? store_name;

  @JsonKey(name: 'store_to_base_rate')
  final int ?store_to_base_rate;


  @JsonKey(name: 'store_to_order_rate')
  final int ?store_to_order_rate;

  @JsonKey(name: 'subtotal')
  final double? subtotal;

  @JsonKey(name: 'subtotal_canceled')
  final double? subtotal_canceled;

  @JsonKey(name: 'subtotal_incl_tax')
  final double? subtotal_incl_tax;

  @JsonKey(name: 'tax_amount')
  final double? tax_amount;

  @JsonKey(name: 'tax_canceled')
  final double? tax_canceled;

  @JsonKey(name: 'total_canceled')
  final double? total_canceled;

  @JsonKey(name: 'total_due')
  final double? total_due;

  @JsonKey(name: 'total_item_count')
  final int? total_item_count;

  @JsonKey(name: 'total_qty_ordered')
  final int? total_qty_ordered;

  @JsonKey(name: 'updated_at')
  final String? updated_at;

  @JsonKey(name: 'weight')
  final double? weight;

  @JsonKey(name: 'x_forwarded_for')
  final String? x_forwarded_for;

  @JsonKey(name: 'items')
  final List<ProductMyItemResponse>? products;
  @JsonKey(name: 'billing_address')
  final BillingOrderAddressResponse? billingOrderAddressResponse;
  @JsonKey(name: 'payment')
  final PaymentOrderResponse? paymentOrderResponse;
  @JsonKey(name: 'status_histories')
  final List<StatusHistoryOrderResponse>? statusHistoryList;
  @JsonKey(name: 'extension_attributes')
  final ExtenstionAttributesOrderResponse? extenstionAttributesOrderResponse;
  MyItemResponse({ this.order_id,this.applied_rule_ids,  this.base_currency_code,  this.base_discount_amount,
     this.base_discount_canceled,  this.base_grand_total,  this.base_discount_tax_compensation_amount,
     this.base_shipping_amount,  this.base_shipping_canceled,  this.base_shipping_discount_amount,
     this.base_shipping_discount_tax_compensation_amnt,  this.base_shipping_incl_tax,
     this.base_shipping_tax_amount,  this.base_subtotal,  this.base_tax_amount,
     this.base_tax_canceled,  this.base_total_canceled,  this.base_total_due,
     this.base_to_global_rate,  this.discount_tax_compensation_amount,  this.base_to_order_rate,
     this.billing_address_id,  this.coupon_code,  this.created_at,

     this.customer_email,  this.customer_firstname,  this.customer_group_id,
     this.customer_id,  this.customer_is_guest,  this.customer_lastname,
     this.customer_note_notify,  this.discount_amount,  this.discount_canceled,
     this.discount_description,  this.entity_id,  this.global_currency_code,
     this.grand_total,  this.increment_id,  this.is_virtual,
     this.order_currency_code,  this.protect_code,  this.quote_id,
     this.remote_ip,  this.shipping_amount,  this.shipping_canceled,
     this.shipping_description,  this.shipping_discount_amount,  this.shipping_discount_tax_compensation_amount,
     this.shipping_incl_tax, this.shipping_tax_amount, this.state, this.status,
     this.store_currency_code, this.store_id, this.store_name, this.store_to_base_rate,
     this.store_to_order_rate,  this.subtotal, this.subtotal_canceled,
     this.subtotal_incl_tax,  this.tax_amount, this.tax_canceled,
     this.total_canceled,  this.total_due, this.total_item_count,
     this.total_qty_ordered,  this.updated_at, this.weight,
     this.x_forwarded_for,  this.products,
   this.billingOrderAddressResponse, this.paymentOrderResponse, this.statusHistoryList, this.extenstionAttributesOrderResponse});

  factory MyItemResponse.fromJson(Map<String, dynamic> json) => _$MyItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyItemResponseToJson(this);
}

@JsonSerializable()
class MyOrdersResponse {

  @JsonKey(name: 'items')
  final List<MyItemResponse> orders;

  MyOrdersResponse({ required this.orders});

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) => _$MyOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrdersResponseToJson(this);
}

@JsonSerializable()
class BillingOrderAddressResponse {
  @JsonKey(name: 'address_type')
  String? address_type;

  @JsonKey(name: 'city')
  String? city;



  @JsonKey(name: 'country_id')
  String? country_id;



  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'entity_id')
  int? entity_id;



  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'parent_id')
  int? parent_id;

  @JsonKey(name: 'customer_id')
  int? customerId;

  @JsonKey(name: 'postcode')
  String? postcode;
  @JsonKey(name: 'region')
  String? region;
  @JsonKey(name: 'region_code')
  String? region_code;
  @JsonKey(name: 'region_id')
  int? region_id;
  @JsonKey(name: 'street')
  List<String>? street;
  @JsonKey(name: 'telephone')
  String? telephone;

  BillingOrderAddressResponse({
    required this.address_type,
    required this.city,

    required this.country_id,
    required this.email,
    required this.entity_id,
    required this.firstname,

    required this.lastname,
    required this.parent_id,
    required this.postcode,
    required this.region,
    required this.region_code,
    required this.region_id,
    required this.street,
    required this.telephone,
  });

  factory BillingOrderAddressResponse.fromJson(Map<String, dynamic> json) => _$BillingOrderAddressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BillingOrderAddressResponseToJson(this);
}

@JsonSerializable()
class PaymentOrderResponse {
  @JsonKey(name: 'account_status')
  String? account_status;

  @JsonKey(name: 'additional_information')
  List<dynamic>? additional_information;



  @JsonKey(name: 'amount_ordered')
  double? amount_ordered;

  @JsonKey(name: 'base_amount_ordered')
  double? base_amount_ordered;

  @JsonKey(name: 'base_shipping_amount')
  double? base_shipping_amount;

  @JsonKey(name: 'cc_exp_year')
  String? cc_exp_year;



  @JsonKey(name: 'cc_last4')
  String? cc_last4;

  @JsonKey(name: 'cc_ss_start_month')
  String? cc_ss_start_month;

  @JsonKey(name: 'cc_ss_start_year')
  String? cc_ss_start_year;

  @JsonKey(name: 'entity_id')
  int? entity_id;

  @JsonKey(name: 'method')
  String? method;
  @JsonKey(name: 'parent_id')
  int? parent_id;
  @JsonKey(name: 'shipping_amount')
  double? shipping_amount;


  PaymentOrderResponse({
    required this.account_status,
    required this.additional_information,

    required this.amount_ordered,
    required this.base_amount_ordered,
    required this.base_shipping_amount,
    required this.cc_exp_year,

    required this.cc_last4,
    required this.cc_ss_start_month,
    required this.cc_ss_start_year,
    required this.entity_id,
    required this.method,
    required this.parent_id,
    required this.shipping_amount,

  });

  factory PaymentOrderResponse.fromJson(Map<String, dynamic> json) => _$PaymentOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentOrderResponseToJson(this);
}


@JsonSerializable()
class StatusHistoryOrderResponse {
  @JsonKey(name: 'comment')
  String? comment;

  @JsonKey(name: 'created_at')
  String? created_at;



  @JsonKey(name: 'entity_id')
  int? entity_id;

  @JsonKey(name: 'entity_name')
  String? entity_name;

  @JsonKey(name: 'is_customer_notified')
  int? is_customer_notified;

  @JsonKey(name: 'is_visible_on_front')
  int? is_visible_on_front;



  @JsonKey(name: 'parent_id')
  int? parent_id;

  @JsonKey(name: 'status')
  String? status;




  StatusHistoryOrderResponse({
    required this.comment,
    required this.created_at,

    required this.entity_id,
    required this.entity_name,
    required this.is_customer_notified,
    required this.is_visible_on_front,

    required this.parent_id,
    required this.status,


  });

  factory StatusHistoryOrderResponse.fromJson(Map<String, dynamic> json) => _$StatusHistoryOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StatusHistoryOrderResponseToJson(this);
}


@JsonSerializable()
class TotalShippingResponse {
  @JsonKey(name: 'base_shipping_amount')
  double? base_shipping_amount;

  @JsonKey(name: 'base_shipping_canceled')
  double? base_shipping_canceled;



  @JsonKey(name: 'base_shipping_discount_amount')
  double? base_shipping_discount_amount;

  @JsonKey(name: 'base_shipping_discount_tax_compensation_amnt')
  double? base_shipping_discount_tax_compensation_amnt;

  @JsonKey(name: 'base_shipping_incl_tax')
  double? base_shipping_incl_tax;

  @JsonKey(name: 'base_shipping_tax_amount')
  double? base_shipping_tax_amount;



  @JsonKey(name: 'shipping_amount')
  double? shipping_amount;

  @JsonKey(name: 'shipping_canceled')
  double? shipping_canceled;
  @JsonKey(name: 'shipping_discount_amount')
  double? shipping_discount_amount;

  @JsonKey(name: 'shipping_discount_tax_compensation_amount')
  double? shipping_discount_tax_compensation_amount;

  @JsonKey(name: 'shipping_incl_tax')
  double? shipping_incl_tax;

  @JsonKey(name: 'shipping_tax_amount')
  double? shipping_tax_amount;



  TotalShippingResponse({
    required this.base_shipping_amount,
    required this.base_shipping_canceled,

    required this.base_shipping_discount_amount,
    required this.base_shipping_discount_tax_compensation_amnt,
    required this.base_shipping_incl_tax,
    required this.base_shipping_tax_amount,

    required this.shipping_amount,
    required this.shipping_canceled,

    required this.shipping_discount_amount,

    required this.shipping_discount_tax_compensation_amount,
    required this.shipping_incl_tax,
    required this.shipping_tax_amount,

  });

  factory TotalShippingResponse.fromJson(Map<String, dynamic> json) => _$TotalShippingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TotalShippingResponseToJson(this);

}

@JsonSerializable()
class ShippingOrderResponse {
  @JsonKey(name: 'address')
  BillingOrderAddressResponse? shippingOrderAddressResponse;
  @JsonKey(name: 'method')
  String? method;
  @JsonKey(name: 'total')
  TotalShippingResponse? totalShippingResponse;
  ShippingOrderResponse(this.shippingOrderAddressResponse,this.method,this.totalShippingResponse);
  factory ShippingOrderResponse.fromJson(Map<String, dynamic> json) => _$ShippingOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOrderResponseToJson(this);


}
@JsonSerializable()
class ShippingAssignmentOrderResponse {
  @JsonKey(name: 'shipping')
  ShippingOrderResponse? shippingOrderResponse;
  @JsonKey(name: 'items')
  List<ProductMyItemResponse>? products;

  ShippingAssignmentOrderResponse(this.shippingOrderResponse,this.products);
  factory ShippingAssignmentOrderResponse.fromJson(Map<String, dynamic> json) => _$ShippingAssignmentOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingAssignmentOrderResponseToJson(this);


}

@JsonSerializable()
class PaymentAdditionalInfoResponse {
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'value')
  String? value;

  PaymentAdditionalInfoResponse(this.key,this.value);
  factory PaymentAdditionalInfoResponse.fromJson(Map<String, dynamic> json) => _$PaymentAdditionalInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentAdditionalInfoResponseToJson(this);


}


@JsonSerializable()
class ExtenstionAttributesOrderResponse {
  @JsonKey(name: 'shipping_assignments')
  List<ShippingAssignmentOrderResponse>? shippingAssignmentList;
  @JsonKey(name: 'payment_additional_info')
  List<PaymentAdditionalInfoResponse>? paymentAdditionalList;

  ExtenstionAttributesOrderResponse(this.shippingAssignmentList,this.paymentAdditionalList);
  factory ExtenstionAttributesOrderResponse.fromJson(Map<String, dynamic> json) => _$ExtenstionAttributesOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtenstionAttributesOrderResponseToJson(this);


}