class GroupOptionsModel {
  final String? sku;
  final String? linkType;
  final String? linkedProductSku;
  final String? linkedProductType;
  final int? position;
  final ExtensionAttributesModel? extensionAttributesModel;

  GroupOptionsModel({
    this.sku,
    this.linkType,
    this.linkedProductSku,
    this.linkedProductType,
    this.position,
    this.extensionAttributesModel,
  });
}

class ExtensionAttributesModel {

  final int? qty;

  ExtensionAttributesModel ({
    this.qty,
  });
  }
