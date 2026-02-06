import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/domain/model/my_orders_model.dart';


import '../response/my_orders_response.dart';

extension ProductMyItemResponseMapper on ProductMyItemResponse?{
  ProductMyItemModel toDomain(){
    return ProductMyItemModel(

        amount_refunded: this?.amount_refunded.orDoubleZero()??Constants.zeroDouble,
        base_amount_refunded: this?.base_amount_refunded.orDoubleZero()??Constants.zeroDouble, base_cost: this?.base_cost.orDoubleZero()??Constants.zeroDouble, base_discount_amount: this?.base_discount_amount.orDoubleZero()??Constants.zeroDouble,
        base_discount_invoiced:  this?.base_discount_invoiced.orDoubleZero()??Constants.zeroDouble,
        base_discount_tax_compensation_amount:  this?.base_discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
        base_original_price:  this?.base_original_price.orDoubleZero()??Constants.zeroDouble,
        base_price:   this?.base_price.orDoubleZero()??Constants.zeroDouble,
        base_price_incl_tax:   this?.base_price_incl_tax.orDoubleZero()??Constants.zeroDouble,
        base_row_invoiced:    this?.base_row_invoiced.orDoubleZero()??Constants.zeroDouble,
        base_row_total: this?.base_row_total.orDoubleZero()??Constants.zeroDouble,
        base_row_total_incl_tax: this?.base_row_total_incl_tax.orDoubleZero()??Constants.zeroDouble,
        base_tax_amount:  this?.base_tax_amount.orDoubleZero()??Constants.zeroDouble,
        base_tax_invoiced: this?.base_tax_invoiced.orDoubleZero()??Constants.zeroDouble,
        created_at:  this?.created_at.orEmpty()??Constants.empty, discount_amount: this?.discount_amount.orDoubleZero()??Constants.zeroDouble,
        discount_invoiced: this?.discount_invoiced.orDoubleZero()??Constants.zeroDouble,
        discount_percent:  this?.discount_percent.orDoubleZero()??Constants.zeroDouble,
        free_shipping: this?.free_shipping.orDoubleZero()??Constants.zeroDouble, discount_tax_compensation_amount: this?.discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
        discount_tax_compensation_canceled:  this?.discount_tax_compensation_canceled.orDoubleZero()??Constants.zeroDouble,
        is_qty_decimal: this?.is_qty_decimal.orDoubleZero()??Constants.zeroDouble, is_virtual: this?.is_virtual.orDoubleZero()??Constants.zeroDouble, item_id:  this?.item_id.orZero()??Constants.zero, name: this?.name.orEmpty()??Constants.empty, no_discount:  this?.no_discount.orDoubleZero()??Constants.zeroDouble, order_id: this?.order_id.orZero()??Constants.zero, original_price: this?.original_price.orDoubleZero()??Constants.zeroDouble, price: this?.price.orDoubleZero()??Constants.zeroDouble,
        price_incl_tax: this?.price_incl_tax.orDoubleZero()??Constants.zeroDouble, product_id: this?.product_id.orZero()??Constants.zero,
        product_type: this?.product_type.orEmpty()??Constants.empty, qty_canceled: this?.qty_canceled.orZero()??Constants.zero, qty_invoiced: this?.qty_invoiced.orZero()??Constants.zero, qty_ordered: this?.qty_ordered.orZero()??Constants.zero, qty_refunded: this?.qty_refunded.orZero()??Constants.zero, qty_shipped:  this?.qty_shipped.orZero()??Constants.zero, quote_item_id: this?.quote_item_id.orZero()??Constants.zero, row_invoiced: this?.row_invoiced.orZero()??Constants.zero, row_total:  this?.row_total.orDoubleZero()??Constants.zeroDouble, row_total_incl_tax: this?.row_total_incl_tax.orDoubleZero()??Constants.zeroDouble, row_weight: this?.row_weight.orDoubleZero()??Constants.zeroDouble, sku: this?.sku.orEmpty()??Constants.empty, store_id: this?.store_id.orZero()??Constants.zero, tax_amount: this?.tax_amount.orDoubleZero()??Constants.zeroDouble, tax_canceled: this?.tax_canceled.orDoubleZero()??Constants.zeroDouble, tax_invoiced: this?.tax_invoiced.orDoubleZero()??Constants.zeroDouble, tax_percent: this?.tax_percent.orDoubleZero()??Constants.zeroDouble,
        updated_at: this?.updated_at.orEmpty()??Constants.empty,
    imageExtension: this!.imageExtension.toDomain());


  }

}

extension MyItemResponseMapper on MyItemResponse?{

   MyItemModel toDomain(){
     List<ProductMyItemModel> productsList = (this

         ?.products!
         .map((academiesResponse) => academiesResponse.toDomain()) ??
         const Iterable.empty())
         .cast<ProductMyItemModel>()
         .toList();

     List<StatusHistoryOrderModel> statusHistoryList = (this

         ?.statusHistoryList!
         .map((academiesResponse) => academiesResponse.toDomain()) ??
         const Iterable.empty())
         .cast<StatusHistoryOrderModel>()
         .toList();
     return MyItemModel(
       order_id: this?.order_id.orZero()??Constants.zero,
         applied_rule_ids: this?.applied_rule_ids.orEmpty()??Constants.empty,
         base_currency_code: this?.base_currency_code.orEmpty()??Constants.empty,
         base_discount_amount: this?.base_discount_amount.orDoubleZero()??Constants.zeroDouble,
         base_discount_canceled: this?.base_discount_canceled.orDoubleZero()??Constants.zeroDouble,
         base_grand_total: this?.base_grand_total.orDoubleZero()??Constants.zeroDouble,
         base_discount_tax_compensation_amount: this?.base_discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
         base_shipping_amount: this?.base_shipping_amount.orDoubleZero()??Constants.zeroDouble,
         base_shipping_canceled: this?.base_shipping_canceled.orDoubleZero()??Constants.zeroDouble,
         base_shipping_discount_amount: this?.base_shipping_discount_amount.orDoubleZero()??Constants.zeroDouble,
         base_shipping_discount_tax_compensation_amnt: this?.base_shipping_discount_tax_compensation_amnt.orDoubleZero()??Constants.zeroDouble,
         base_shipping_incl_tax:  this?.base_shipping_incl_tax.orDoubleZero()??Constants.zeroDouble,

         base_shipping_tax_amount: this?.base_shipping_tax_amount.orDoubleZero()??Constants.zeroDouble,
         base_subtotal: this?.base_subtotal.orDoubleZero()??Constants.zeroDouble,
         base_tax_amount: this?.base_tax_amount.orDoubleZero()??Constants.zeroDouble, base_tax_canceled: this?.base_tax_canceled.orDoubleZero()??Constants.zeroDouble,
         base_total_canceled: this?.base_total_canceled.orDoubleZero()??Constants.zeroDouble,
         base_total_due:  this?.base_total_due.orDoubleZero()??Constants.zeroDouble,
         base_to_global_rate:  this?.base_to_global_rate.orDoubleZero()??Constants.zeroDouble,
         discount_tax_compensation_amount:  this?.discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
         base_to_order_rate:  this?.base_to_order_rate.orDoubleZero()??Constants.zeroDouble,
         billing_address_id: this?.billing_address_id.orZero()??Constants.zero,
         coupon_code: this?.coupon_code.orEmpty()??Constants.empty,
         created_at: this?.created_at.orEmpty()??Constants.empty,
         customer_email: this?.customer_email.orEmpty()??Constants.empty,
         customer_firstname: this?.customer_firstname.orEmpty()??Constants.empty,
         customer_group_id: this?.customer_group_id.orZero()??Constants.zero, customer_id: this?.customer_id.orZero()??Constants.zero,
         customer_is_guest: this?.customer_is_guest.orZero()??Constants.zero, customer_lastname: this?.customer_lastname.orEmpty()??Constants.empty,
         customer_note_notify: this?.customer_note_notify.orZero()??Constants.zero,
         discount_amount:  this?.discount_amount.orDoubleZero()??Constants.zeroDouble, discount_canceled: this?.discount_canceled.orDoubleZero()??Constants.zeroDouble,
         discount_description:  this?.discount_description.orEmpty()??Constants.empty,
         entity_id:  this?.entity_id.orZero()??Constants.zero, global_currency_code:  this?.global_currency_code.orEmpty()??Constants.empty, grand_total:  this?.grand_total.orDoubleZero()??Constants.zeroDouble,
         increment_id:  this?.increment_id.orEmpty()??Constants.empty, is_virtual: this?.is_virtual.orZero()??Constants.zero,
         order_currency_code:  this?.order_currency_code.orEmpty()??Constants.empty,
         protect_code: this?.protect_code.orEmpty()??Constants.empty, quote_id: this?.quote_id.orZero()??Constants.zero,
         remote_ip: this?.remote_ip.orEmpty()??Constants.empty, shipping_amount: this?.shipping_amount.orDoubleZero()??Constants.zeroDouble,
         shipping_canceled: this?.shipping_canceled.orDoubleZero()??Constants.zeroDouble,
         shipping_description: this?.shipping_description.orEmpty()??Constants.empty,
         shipping_discount_amount: this?.shipping_discount_amount.orDoubleZero()??Constants.zeroDouble,
         shipping_discount_tax_compensation_amount:  this?.shipping_discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
         shipping_incl_tax: this?.shipping_incl_tax.orDoubleZero()??Constants.zeroDouble,
         shipping_tax_amount: this?.shipping_tax_amount.orDoubleZero()??Constants.zeroDouble,
         state: this?.state.orEmpty()??Constants.empty, status:  this?.status.orEmpty()??Constants.empty,
         store_currency_code:  this?.store_currency_code.orEmpty()??Constants.empty, store_id:  this?.store_id.orZero()??Constants.zero,
         store_name:   this?.store_name.orEmpty()??Constants.empty,
         store_to_base_rate: this?.store_to_base_rate.orZero()??Constants.zero, store_to_order_rate:  this?.store_to_order_rate.orZero()??Constants.zero,
         subtotal:  this?.subtotal.orDoubleZero()??Constants.zeroDouble,
         subtotal_canceled: this?.subtotal_canceled.orDoubleZero()??Constants.zeroDouble,
         subtotal_incl_tax: this?.subtotal_incl_tax.orDoubleZero()??Constants.zeroDouble,
         tax_amount: this?.tax_amount.orDoubleZero()??Constants.zeroDouble,
         tax_canceled:  this?.tax_canceled.orDoubleZero()??Constants.zeroDouble,
         total_canceled: this?.total_canceled.orDoubleZero()??Constants.zeroDouble,
         total_due:  this?.total_due.orDoubleZero()??Constants.zeroDouble,
         total_item_count: this?.total_item_count.orZero()??Constants.zero, total_qty_ordered:  this?.total_qty_ordered.orZero()??Constants.zero,
         updated_at: this?.updated_at.orEmpty()??Constants.empty,
         weight: this?.weight.orDoubleZero()??Constants.zeroDouble,
         x_forwarded_for: this?.x_forwarded_for.orEmpty()??Constants.empty, products: productsList, billingOrderAddressResponse: this!.billingOrderAddressResponse.toDomain(),
         paymentOrderResponse:this!.paymentOrderResponse!.toDomain(),
         statusHistoryList:statusHistoryList,
         extenstionAttributesOrderResponse:this!.extenstionAttributesOrderResponse!.toDomain()
     );
   }

}
extension ImageExtensionMapper on ImageExtension?{
  ImageExtensionModel toDomain(){
    return ImageExtensionModel(product_image: this?.product_image.orEmpty()??Constants.empty);
  }
}
extension MyOrdersResponseMapper on MyOrdersResponse?{
  MyOrdersModel toDomain(){
    List<MyItemModel> ordersList = (this

        ?.orders
        .map((academiesResponse) => academiesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<MyItemModel>()
        .toList();
    return MyOrdersModel(orders: ordersList);
  }
}
extension billingOrderAddressResponseMapper on BillingOrderAddressResponse?{
  List<String> get streets {
    return (this?.street
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<String>()
        .toList();

  }
  BillingOrderAddressModel toDomain(){

    return BillingOrderAddressModel(address_type: this?.address_type.orEmpty()??Constants.empty,
        city: this?.city.orEmpty()??Constants.empty,
        country_id: this?.country_id.orEmpty()??Constants.empty,
        email:  this?.email.orEmpty()??Constants.empty,
        entity_id:  this?.entity_id.orZero()??Constants.zero, firstname:
        this?.firstname.orEmpty()??Constants.empty,
        lastname:  this?.lastname.orEmpty()??Constants.empty,
        parent_id:  this?.parent_id.orZero()??Constants.zero,
        postcode:  this?.postcode.orEmpty()??Constants.empty,
        region:  this?.region.orEmpty()??Constants.empty,
        region_code:  this?.region_code.orEmpty()??Constants.empty,
        region_id:  this?.region_id.orZero()??Constants.zero,
        street:  streets, telephone:  this?.telephone.orEmpty()??Constants.empty);
  }
}
extension PaymentOrderResponseMapper on PaymentOrderResponse{
  List<dynamic> get additionalInfoList {
    return (this?.additional_information
        ?.map((childResponse) => childResponse) ??
        const Iterable.empty())
        .cast<dynamic>()
        .toList();

  }
  PaymentOrderModel toDomain(){
    return PaymentOrderModel(account_status: this?.account_status.orEmpty()??Constants.empty, additional_information: additionalInfoList, amount_ordered: this?.amount_ordered.orDoubleZero()??Constants.zeroDouble, base_amount_ordered: this?.base_amount_ordered.orDoubleZero()??Constants.zeroDouble, base_shipping_amount: this?.base_shipping_amount.orDoubleZero()??Constants.zeroDouble,
        cc_exp_year: this?.cc_exp_year.orEmpty()??Constants.empty, cc_last4: this?.cc_last4.orEmpty()??Constants.empty, cc_ss_start_month: this?.cc_ss_start_month.orEmpty()??Constants.empty, cc_ss_start_year: this?.cc_ss_start_year.orEmpty()??Constants.empty, entity_id:  this?.entity_id.orZero()??Constants.zero,
        method:  this?.method.orEmpty()??Constants.empty,
        parent_id:   this?.parent_id.orZero()??Constants.zero, shipping_amount: this?.shipping_amount.orDoubleZero()??Constants.zeroDouble);
  }
}
extension StatusHistoryOrderResponseMapper on StatusHistoryOrderResponse{
  StatusHistoryOrderModel toDomain(){
    return StatusHistoryOrderModel(comment: this?.comment.orEmpty()??Constants.empty,
        created_at: this?.created_at.orEmpty()??Constants.empty,
        entity_id: this?.entity_id.orZero()??Constants.zero,
        entity_name: this?.entity_name.orEmpty()??Constants.empty,
        is_customer_notified: this?.is_customer_notified.orZero()??Constants.zero,
        is_visible_on_front: this?.is_visible_on_front.orZero()??Constants.zero,
        parent_id: this?.parent_id.orZero()??Constants.zero,
        status: this?.status.orEmpty()??Constants.empty);
  }
}
extension TotalShippingResponseMapper on TotalShippingResponse{
  TotalShippingModel toDomain(){
    return TotalShippingModel(base_shipping_amount: this?.base_shipping_amount.orDoubleZero()??Constants.zeroDouble,
        base_shipping_canceled: this?.base_shipping_canceled.orDoubleZero()??Constants.zeroDouble,
        base_shipping_discount_amount:  this?.base_shipping_discount_amount.orDoubleZero()??Constants.zeroDouble,
        base_shipping_discount_tax_compensation_amnt: this?.base_shipping_discount_tax_compensation_amnt.orDoubleZero()??Constants.zeroDouble,
        base_shipping_incl_tax:  this?.base_shipping_incl_tax.orDoubleZero()??Constants.zeroDouble,
        base_shipping_tax_amount:  this?.base_shipping_tax_amount.orDoubleZero()??Constants.zeroDouble,
        shipping_amount:   this?.shipping_amount.orDoubleZero()??Constants.zeroDouble,
        shipping_canceled:  this?.shipping_canceled.orDoubleZero()??Constants.zeroDouble,
        shipping_discount_amount: this?.shipping_discount_amount.orDoubleZero()??Constants.zeroDouble,
        shipping_discount_tax_compensation_amount: this?.shipping_discount_tax_compensation_amount.orDoubleZero()??Constants.zeroDouble,
        shipping_incl_tax: this?.shipping_incl_tax.orDoubleZero()??Constants.zeroDouble, shipping_tax_amount: this?.shipping_tax_amount.orDoubleZero()??Constants.zeroDouble);
  }
}

extension ShippingOrderResponseMapper on ShippingOrderResponse{
  ShippingOrderModel toDomain(){
    return ShippingOrderModel(this.shippingOrderAddressResponse.toDomain(), this?.method.orEmpty()??Constants.empty,this.totalShippingResponse?.toDomain());
  }
}
extension ShippingAssignmentOrderResponseMapper on ShippingAssignmentOrderResponse{
  ShippingAssignmentOrderModel toDomain(){
    List<ProductMyItemModel> productsList = (this

        ?.products!
        .map((academiesResponse) => academiesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<ProductMyItemModel>()
        .toList();
    return ShippingAssignmentOrderModel(this.shippingOrderResponse?.toDomain(), productsList);
  }
}

extension PaymentAdditionalInfoResponseMapper on PaymentAdditionalInfoResponse{
  PaymentAdditionalInfoModel toDomain(){
    return PaymentAdditionalInfoModel(this?.key.orEmpty()??Constants.empty, this?.value.orEmpty()??Constants.empty);
  }
}

extension ExtenstionAttributesOrderResponseMapper on ExtenstionAttributesOrderResponse{

  ExtenstionAttributesOrderModel toDomain(){
    List<ShippingAssignmentOrderModel> shippingAssignList = (this

        ?.shippingAssignmentList!
        .map((academiesResponse) => academiesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<ShippingAssignmentOrderModel>()
        .toList();
    List<PaymentAdditionalInfoModel> paymentList = (this

        ?.paymentAdditionalList!
        .map((academiesResponse) => academiesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<PaymentAdditionalInfoModel>()
        .toList();
    return ExtenstionAttributesOrderModel(shippingAssignList, paymentList);
  }
}