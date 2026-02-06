class BundleProductOptionsModel {
  final int? optionId;
  final String? title;
  final bool? required;
  final String? type;
  final int? position;
  final String? sku;
  final List<ProductLinksModel>? productLinks;

  BundleProductOptionsModel({
    this.optionId,
    this.title,
    this.required,
    this.type,
    this.position,
    this.sku,
    this.productLinks,
  });
}

class ProductLinksModel {
  final String? id;
  final String? sku;
  final int? optionId;
  final int? qty;
  final int? position;
  final bool? isDefault;
  final int? price;
  final int? priceType;
  final int? canChangeQuantity;

  ProductLinksModel({
    this.id,
    this.sku,
    this.optionId,
    this.qty,
    this.position,
    this.isDefault,
    this.price,
    this.priceType,
    this.canChangeQuantity,
  });
}
