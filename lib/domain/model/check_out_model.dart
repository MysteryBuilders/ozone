class CheckOutItemModel {

  int? itemId;

  double? price;

  double? basePrce;

  int? qty;

  double? rowTotal;

  double? baseRowTotal;

  double? rowTotalWithDiscount;

  double? taxAmount;

  double? baseTaxAmount;

  double? taxPrecent;

  double? discountAmount;

  double? baseDiscountAmount;

  double? discountPrecent;

  double? priceInclTax;

  double? rowTotalInclTax;

  double? basePriceInclTax;

  double? baseRowTotalInclTax;

  String? weeeTaxAppliedAmount;

  String? weeeTaxApplied;

  String? name;
  ExtenstionAttibutesModel extenstionAttibutesModel;
  CheckOutItemModel({
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
    required this.extenstionAttibutesModel


  });

 }

class CheckOutModel {


  double? grandTotal;

  double? baseGrandTotal;

  double? subtotal;

  double? baseSubTotal;

  double? discountAmount;

  double? baseDiscountAmount;

  double? subTotalWithDiscount;

  double? basesubTotalWithDiscount;

  double? shippingAmount;

  double? baseShippingAmount;

  double? shippingDiscountAmount;

  double? baseshippingDiscountAmount;

  double? taxAmount;

  double? baseTaxAmount;

  double? shippingTaxAmount;

  double? baseshippingTaxAmount;

  double? subTotalInclTax;

  double? shippingInclTax;

  double? baseshippingInclTax;


  String? baseCurrencyCode;

  String? quoteCurrencyCode;

  String? coupounCode;

  int? itemsQty;

  List<CheckOutItemModel>? list;
  List<totalSegmentsModel>? totalSegments;

  CheckOutModel({
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

    required this.list,required this.totalSegments



  });

  }
class ExtenstionAttibutesModel{

  String? image_url;

  ExtenstionAttibutesModel({required this.image_url});

}

class totalSegmentsModel{

  String? code;

  String? title;

  double? value;
  totalSegmentsModel({required this.code,required this.title,required this.value});

}