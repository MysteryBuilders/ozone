import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/mapper/bundle_product_options_mapper.dart';
import 'package:ozon/data/mapper/group_option_mapper.dart';
import 'package:ozon/data/response/products_response.dart';
import 'package:ozon/domain/model/products_model.dart';

import '../../app/constants.dart';

extension ProductsResponseMapper on ProductsResponse? {
  ProductsModel toDomain() {
    return ProductsModel(
      items: this?.items?.map((item) => item.toDomain()).toList(),
      searchCriteria: this?.searchCriteria?.toDomain(),
      totalCount: this?.totalCount,
    );
  }
}

extension ItemsResponseMapper on Items? {
  ProductItemModel toDomain() {
    return ProductItemModel(
      id: this?.id,
      sku: this?.sku ?? Constants.empty,
      name: this?.name ?? Constants.empty,
      attributeSetId: this?.attributeSetId,
      price: this?.price,
      status: this?.status,
      visibility: this?.visibility,
      typeId: this?.typeId ?? Constants.empty,
      createdAt: this?.createdAt ?? Constants.empty,
      updatedAt: this?.updatedAt ?? Constants.empty,
      weight: this?.weight,
      extensionAttributes: this?.extensionAttributes?.toDomain(),
      groupOptions: this?.productLinks?.map((e) => e.toDomain()).toList(),
      mediaGalleryEntries: this?.mediaGalleryEntries?.map((e) => e.toDomain()).toList(),

      customAttributes: this?.customAttributes?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension ExtensionAttributesResponseMapper on ExtensionAttributes? {
  ExtensionAttributesModel toDomain() {
    return ExtensionAttributesModel(
      websiteIds: this?.websiteIds,
      categoryLinks: this?.categoryLinks?.map((e) => e.toDomain()).toList(),
      bundleProductOptions: this?.bundleProductOptions?.map((e) => e.toDomain()).toList(),
      codazonLabels: this?.codazonLabels?.map((e) => e).toList(),
    );
  }
}

extension CategoryLinkResponseMapper on CategoryLinks? {
  CategoryLinkModel toDomain() {
    return CategoryLinkModel(
      position: this?.position,
      categoryId: this?.categoryId ?? Constants.empty,
    );
  }
}

extension MediaGalleryEntryResponseMapper on MediaGalleryEntries? {
  MediaGalleryEntryModel toDomain() {
    return MediaGalleryEntryModel(
      id: this?.id,
      mediaType: this?.mediaType ?? Constants.empty,

      position: this?.position,
      disabled: this?.disabled ?? false,
      types: this?.types?.map((e) => e ?? Constants.empty).whereType<String>().toList(),
      file: this?.file ?? Constants.empty,
    );
  }
}

extension CustomAttributeResponseMapper on CustomAttributes? {
  CustomAttributeModel toDomain() {
    return CustomAttributeModel(
      attributeCode: this?.attributeCode ?? Constants.empty,
      value: this?.value,
    );
  }
}

extension SearchCriteriaResponseMapper on SearchCriteria? {
  SearchCriteriaModel toDomain() {
    return SearchCriteriaModel(
      filterGroups: this?.filterGroups?.map((e) => e.toDomain()).toList(),

      sortOrders: this?.sortOrders?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension FilterGroupResponseMapper on FilterGroups? {
  FilterGroupModel toDomain() {
    return FilterGroupModel(
      filters: this?.filters?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension FilterResponseMapper on Filters? {
  FilterModel toDomain() {
    return FilterModel(

      value: this?.value ?? Constants.empty,
      conditionType: this?.conditionType ?? Constants.empty,
    );
  }
}

extension SortOrderResponseMapper on SortOrders? {
  SortOrderModel toDomain() {
    return SortOrderModel(

      direction: this?.direction ?? Constants.empty,
    );
  }
}
