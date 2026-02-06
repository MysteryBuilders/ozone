


class ProductMyItemModel {


  final double amount_refunded;


  final double base_amount_refunded;


  final double base_cost;


  final double base_discount_amount;


  final double base_discount_invoiced;


  final double base_discount_tax_compensation_amount;



  final double base_original_price;

  final double base_price;


  final double base_price_incl_tax;

  final double base_row_invoiced;


  final double base_row_total;


  final double base_row_total_incl_tax;



  final double base_tax_amount;


  final double base_tax_invoiced;

  final String created_at;


  final double discount_amount;


  final double discount_invoiced;

  final double discount_percent;


  final double free_shipping;


  final double discount_tax_compensation_amount;


  final double discount_tax_compensation_canceled;


  final double is_qty_decimal;

  final double is_virtual;


  final int item_id;




  final String name;


  final double no_discount;


  final int order_id;


  final double original_price;


  final double price;


  final double price_incl_tax;



  final int product_id;


  final String product_type;


  final int qty_canceled;


  final int qty_invoiced;


  final int qty_ordered;


  final int qty_refunded;



  final int qty_shipped;


  final int quote_item_id;


  final int row_invoiced;


  final double row_total;


  final double row_total_incl_tax;


  final double row_weight;



  final String sku;


  final int store_id;


  final double tax_amount;


  final double tax_canceled;


  final double tax_invoiced;


  final double tax_percent;


  final String updated_at;
  final ImageExtensionModel imageExtension;

  ProductMyItemModel({required this.amount_refunded, required this.base_amount_refunded, required this.base_cost,
    required this.base_discount_amount, required this.base_discount_invoiced, required this.base_discount_tax_compensation_amount,
    required this.base_original_price, required this.base_price, required this.base_price_incl_tax,
    required this.base_row_invoiced, required this.base_row_total, required this.base_row_total_incl_tax,
    required this.base_tax_amount, required this.base_tax_invoiced, required this.created_at,
    required this.discount_amount, required this.discount_invoiced, required this.discount_percent,
    required this.free_shipping, required this.discount_tax_compensation_amount, required this.discount_tax_compensation_canceled,
    required this.is_qty_decimal, required this.is_virtual, required this.item_id,

    required this.name, required this.no_discount, required this.order_id,
    required this.original_price, required this.price, required this.price_incl_tax,
    required this.product_id, required this.product_type, required this.qty_canceled,
    required this.qty_invoiced, required this.qty_ordered, required this.qty_refunded,
    required this.qty_shipped, required this.quote_item_id, required this.row_invoiced,
    required this.row_total, required this.row_total_incl_tax, required this.row_weight,
    required this.sku, required this.store_id, required this.tax_amount,
    required this.tax_canceled, required this.tax_invoiced, required this.tax_percent,
    required this.updated_at,
  required this.imageExtension});

}


class ImageExtensionModel{

  final String product_image;
  ImageExtensionModel({required this.product_image});

}
class MyItemModel {
  final int order_id;
  final String applied_rule_ids;


  final String base_currency_code;


  final double base_discount_amount;


  final double base_discount_canceled;


  final double base_grand_total;


  final double base_discount_tax_compensation_amount;



  final double base_shipping_amount;


  final double base_shipping_canceled;


  final double base_shipping_discount_amount;


  final double base_shipping_discount_tax_compensation_amnt;


  final double base_shipping_incl_tax;






  final double base_shipping_tax_amount;


  final double base_subtotal;


  final double base_tax_amount;


  final double base_tax_canceled;


  final double base_total_canceled;


  final double base_total_due;



  final double base_to_global_rate;


  final double discount_tax_compensation_amount;


  final double base_to_order_rate;


  final int billing_address_id;


  final String coupon_code;


  final String created_at;




  final String customer_email;


  final String customer_firstname;


  final int customer_group_id;


  final int customer_id;


  final int customer_is_guest;


  final String customer_lastname;



  final int customer_note_notify;


  final double discount_amount;

  final double discount_canceled;


  final String discount_description;


  final int entity_id;


  final String global_currency_code;



  final double grand_total;

  final String increment_id;


  final int is_virtual;


  final String order_currency_code;

  final String protect_code;


  final int quote_id;



  final String remote_ip;


  final double shipping_amount;


  final double shipping_canceled;


  final String shipping_description;


  final double shipping_discount_amount;


  final double shipping_discount_tax_compensation_amount;


  final double shipping_incl_tax;



  final double shipping_tax_amount;


  final String state;


  final String status;


  final String store_currency_code;


  final int store_id;


  final String store_name;


  final int store_to_base_rate;



  final int store_to_order_rate;


  final double subtotal;


  final double subtotal_canceled;


  final double subtotal_incl_tax;


  final double tax_amount;


  final double tax_canceled;


  final double total_canceled;

  final double total_due;


  final int total_item_count;


  final int total_qty_ordered;


  final String updated_at;


  final double weight;


  final String x_forwarded_for;



  final List<ProductMyItemModel> products;


  final BillingOrderAddressModel billingOrderAddressResponse;

  final PaymentOrderModel paymentOrderResponse;

  final List<StatusHistoryOrderModel> statusHistoryList;

  final ExtenstionAttributesOrderModel extenstionAttributesOrderResponse;


  MyItemModel({required this.order_id,required this.applied_rule_ids, required this.base_currency_code, required this.base_discount_amount,
    required this.base_discount_canceled, required this.base_grand_total, required this.base_discount_tax_compensation_amount,
    required this.base_shipping_amount, required this.base_shipping_canceled, required this.base_shipping_discount_amount,
    required this.base_shipping_discount_tax_compensation_amnt, required this.base_shipping_incl_tax,
    required this.base_shipping_tax_amount, required this.base_subtotal, required this.base_tax_amount,
    required this.base_tax_canceled, required this.base_total_canceled, required this.base_total_due,
    required this.base_to_global_rate, required this.discount_tax_compensation_amount, required this.base_to_order_rate,
    required this.billing_address_id, required this.coupon_code, required this.created_at,

    required this.customer_email, required this.customer_firstname, required this.customer_group_id,
    required this.customer_id, required this.customer_is_guest, required this.customer_lastname,
    required this.customer_note_notify, required this.discount_amount, required this.discount_canceled,
    required this.discount_description, required this.entity_id, required this.global_currency_code,
    required this.grand_total, required this.increment_id, required this.is_virtual,
    required this.order_currency_code, required this.protect_code, required this.quote_id,
    required this.remote_ip, required this.shipping_amount, required this.shipping_canceled,
    required this.shipping_description, required this.shipping_discount_amount, required this.shipping_discount_tax_compensation_amount,
    required this.shipping_incl_tax,required this.shipping_tax_amount,required this.state,required this.status,
    required this.store_currency_code,required this.store_id,required this.store_name,required this.store_to_base_rate,
    required this.store_to_order_rate, required this.subtotal,required this.subtotal_canceled,
    required this.subtotal_incl_tax, required this.tax_amount,required this.tax_canceled,
    required this.total_canceled, required this.total_due,required this.total_item_count,
    required this.total_qty_ordered, required this.updated_at,required this.weight,
    required this.x_forwarded_for, required this.products,
    required this.billingOrderAddressResponse,required this.paymentOrderResponse,required this.statusHistoryList,required this.extenstionAttributesOrderResponse});


}


class MyOrdersModel {


  final List<MyItemModel> orders;

  MyOrdersModel({ required this.orders});

 
}


class BillingOrderAddressModel {

  String? address_type;


  String? city;




  String? country_id;




  String? email;


  int? entity_id;




  String? firstname;


  String? lastname;


  int? parent_id;


  int? customerId;


  String? postcode;

  String? region;

  String? region_code;

  int? region_id;

  List<String>? street;

  String? telephone;

  BillingOrderAddressModel({
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

  }


class PaymentOrderModel {

  String? account_status;


  List<dynamic>? additional_information;




  double? amount_ordered;


  double? base_amount_ordered;


  double? base_shipping_amount;


  String? cc_exp_year;




  String? cc_last4;


  String? cc_ss_start_month;


  String? cc_ss_start_year;


  int? entity_id;


  String? method;

  int? parent_id;

  double? shipping_amount;


  PaymentOrderModel({
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

  }



class StatusHistoryOrderModel {

  String? comment;


  String? created_at;




  int? entity_id;


  String? entity_name;


  int? is_customer_notified;


  int? is_visible_on_front;




  int? parent_id;


  String? status;




  StatusHistoryOrderModel({
    required this.comment,
    required this.created_at,

    required this.entity_id,
    required this.entity_name,
    required this.is_customer_notified,
    required this.is_visible_on_front,

    required this.parent_id,
    required this.status,


  });

}



class TotalShippingModel {

  double? base_shipping_amount;


  double? base_shipping_canceled;




  double? base_shipping_discount_amount;


  double? base_shipping_discount_tax_compensation_amnt;


  double? base_shipping_incl_tax;


  double? base_shipping_tax_amount;




  double? shipping_amount;


  double? shipping_canceled;

  double? shipping_discount_amount;


  double? shipping_discount_tax_compensation_amount;


  double? shipping_incl_tax;


  double? shipping_tax_amount;



  TotalShippingModel({
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


}


class ShippingOrderModel {

  BillingOrderAddressModel? shippingOrderAddressResponse;

  String? method;

  TotalShippingModel? totalShippingResponse;
  ShippingOrderModel(this.shippingOrderAddressResponse,this.method,this.totalShippingResponse);


}

class ShippingAssignmentOrderModel {

  ShippingOrderModel? shippingOrderResponse;

  List<ProductMyItemModel>? products;

  ShippingAssignmentOrderModel(this.shippingOrderResponse,this.products);


}

class PaymentAdditionalInfoModel {

  String? key;

  String? value;

  PaymentAdditionalInfoModel(this.key,this.value);


}



class ExtenstionAttributesOrderModel {

  List<ShippingAssignmentOrderModel>? shippingAssignmentList;

  List<PaymentAdditionalInfoModel>? paymentAdditionalList;

  ExtenstionAttributesOrderModel(this.shippingAssignmentList,this.paymentAdditionalList);


}