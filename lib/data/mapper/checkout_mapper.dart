import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/domain/model/check_out_model.dart';

import '../response/check_out_response.dart';

extension CheckOutItemResponseMapper on CheckOutItemResponse?{
  CheckOutItemModel toDomain(){
    return CheckOutItemModel(itemId: this?.itemId.orZero()??Constants.zero, price: this?.price.orDoubleZero()??Constants.zeroDouble,
      basePrce: this?.basePrce.orDoubleZero()??Constants.zeroDouble, qty: this?.qty.orZero()??Constants.zero, rowTotal:  this?.rowTotal.orDoubleZero()??Constants.zeroDouble, baseRowTotal:  this?.baseRowTotal.orDoubleZero()??Constants.zeroDouble, rowTotalWithDiscount:  this?.rowTotalWithDiscount.orDoubleZero()??Constants.zeroDouble, taxAmount:  this?.taxAmount.orDoubleZero()??Constants.zeroDouble, baseTaxAmount:  this?.baseTaxAmount.orDoubleZero()??Constants.zeroDouble, taxPrecent:  this?.taxPrecent.orDoubleZero()??Constants.zeroDouble, discountAmount:  this?.discountAmount.orDoubleZero()??Constants.zeroDouble,
      baseDiscountAmount:  this?.baseDiscountAmount.orDoubleZero()??Constants.zeroDouble, discountPrecent:  this?.discountPrecent.orDoubleZero()??Constants.zeroDouble, priceInclTax:  this?.priceInclTax.orDoubleZero()??Constants.zeroDouble, basePriceInclTax:  this?.basePriceInclTax.orDoubleZero()??Constants.zeroDouble, rowTotalInclTax:  this?.rowTotalInclTax.orDoubleZero()??Constants.zeroDouble, baseRowTotalInclTax:  this?.baseRowTotalInclTax.orDoubleZero()??Constants.zeroDouble, weeeTaxAppliedAmount:  this?.weeeTaxAppliedAmount.orEmpty()??Constants.empty, weeeTaxApplied: this?.weeeTaxApplied.orEmpty()??Constants.empty, name: this?.name.orEmpty()??Constants.empty,extenstionAttibutesModel: this!.extenstionAttibutesResponse.toDomain()



     
      
    );

  }



}
extension ExtenstionAttibutesResponseMapper on ExtenstionAttibutesResponse?{
  ExtenstionAttibutesModel toDomain(){
    return ExtenstionAttibutesModel(image_url: this?.image_url.orEmpty()??Constants.empty);
  }

}
extension CheckOutResponseMapper on CheckOutResponse?{
  List<CheckOutItemModel> get list {
    return (this?.list
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CheckOutItemModel>()
        .toList();

  }
  List<totalSegmentsModel> get totalSegmentLit {
    return (this?.totalSegments
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<totalSegmentsModel>()
        .toList();

  }
  CheckOutModel toDomain(){
    return CheckOutModel(grandTotal: this?.grandTotal.orDoubleZero()??Constants.zeroDouble, baseGrandTotal: this?.baseGrandTotal.orDoubleZero()??Constants.zeroDouble, subtotal: this?.subtotal.orDoubleZero()??Constants.zeroDouble, baseSubTotal: this?.baseSubTotal.orDoubleZero()??Constants.zeroDouble, discountAmount: this?.discountAmount.orDoubleZero()??Constants.zeroDouble, baseDiscountAmount: this?.baseDiscountAmount.orDoubleZero()??Constants.zeroDouble, subTotalWithDiscount: this?.subTotalWithDiscount.orDoubleZero()??Constants.zeroDouble, basesubTotalWithDiscount: this?.basesubTotalWithDiscount.orDoubleZero()??Constants.zeroDouble, shippingAmount:  this?.shippingAmount.orDoubleZero()??Constants.zeroDouble, baseShippingAmount:  this?.baseShippingAmount.orDoubleZero()??Constants.zeroDouble, shippingDiscountAmount:  this?.shippingDiscountAmount.orDoubleZero()??Constants.zeroDouble, baseshippingDiscountAmount: this?.baseshippingDiscountAmount.orDoubleZero()??Constants.zeroDouble, taxAmount: this?.taxAmount.orDoubleZero()??Constants.zeroDouble, baseTaxAmount: this?.baseTaxAmount.orDoubleZero()??Constants.zeroDouble, shippingTaxAmount: this?.shippingTaxAmount.orDoubleZero()??Constants.zeroDouble, baseshippingTaxAmount: this?.baseshippingTaxAmount.orDoubleZero()??Constants.zeroDouble, subTotalInclTax: this?.subTotalInclTax.orDoubleZero()??Constants.zeroDouble, shippingInclTax: this?.shippingInclTax.orDoubleZero()??Constants.zeroDouble, baseshippingInclTax: this?.baseshippingInclTax.orDoubleZero()??Constants.zeroDouble, baseCurrencyCode: this?.baseCurrencyCode.orEmpty()??Constants.empty, quoteCurrencyCode: this?.quoteCurrencyCode.orEmpty()??Constants.empty, coupounCode:  this?.coupounCode.orEmpty()??Constants.empty, itemsQty:  this?.itemsQty.orZero()??Constants.zero, list: list,totalSegments: totalSegmentLit);

  }



}

extension totalSegmentsResponseMapper on totalSegmentsResponse?{
  totalSegmentsModel toDomain(){
    return totalSegmentsModel(
      code:  this?.code.orEmpty()??Constants.empty,
      title:  this?.title.orEmpty()??Constants.empty,
      value: this?.value.orDoubleZero()??Constants.zeroDouble,
    );

  }

}
