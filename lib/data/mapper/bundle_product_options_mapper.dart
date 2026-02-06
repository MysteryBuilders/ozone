import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/bundle_product_options_response.dart';
import 'package:ozon/domain/model/bundle_product_options_model.dart';
import 'package:ozon/app/constants.dart';

extension ProductLinksMapper on ProductLinks? {
  ProductLinksModel toDomain() {
    return ProductLinksModel(
      id: this?.id.orEmpty() ?? Constants.empty,
      sku: this?.sku.orEmpty() ?? Constants.empty,
      optionId: this?.optionId.orZero() ?? Constants.zero,
      qty: this?.qty.orZero() ?? Constants.zero,
      position: this?.position.orZero() ?? Constants.zero,
      isDefault: this?.isDefault.orBooleanFalse() ?? false,
      price: this?.price.orZero() ?? Constants.zero,
      priceType: this?.priceType.orZero() ?? Constants.zero,
      canChangeQuantity: this?.canChangeQuantity.orZero() ?? Constants.zero,
    );
  }
}

extension BundleProductOptionsResponseMapper on BundleProductOptionsResponse? {
  List<ProductLinksModel> get productLinksList {
    return (this?.productLinks
            ?.map((link) => link.toDomain()) ??
        const Iterable.empty())
        .cast<ProductLinksModel>()
        .toList();
  }

  BundleProductOptionsModel toDomain() {
    return BundleProductOptionsModel(
      optionId: this?.optionId.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      required: this?.required.orBooleanFalse() ?? false,
      type: this?.type.orEmpty() ?? Constants.empty,
      position: this?.position.orZero() ?? Constants.zero,
      sku: this?.sku.orEmpty() ?? Constants.empty,
      productLinks: productLinksList,
    );
  }
}
