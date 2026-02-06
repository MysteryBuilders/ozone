class AddToCartModel{

  int? itemId;

  String? sku;

  int? qty;

  String? name;

  double? price;

  String? productType;

  String? quoteId;

  ExtensionAttirbuteImageModel? extensionAttirbuteImageModel;
  AddToCartModel({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    required this.quoteId,
    required this.extensionAttirbuteImageModel
  });
}

class ExtensionAttirbuteImageModel{
  String imageUrl;
  ExtensionAttirbuteImageModel({required this.imageUrl});

}