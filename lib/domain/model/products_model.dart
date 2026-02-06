import 'package:ozon/domain/model/bundle_product_options_model.dart';
import 'package:ozon/domain/model/group_options_model.dart';

class ProductsModel {
  final List<ProductItemModel>? items;
  final SearchCriteriaModel? searchCriteria;
  final int? totalCount;

  ProductsModel({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });
}

class ProductItemModel {
  final int? id;
  final String? sku;
  final String? name;
  final int? attributeSetId;
  final double? price;
  final int? status;
  final int? visibility;
  final String? typeId;
  final String? createdAt;
  final String? updatedAt;
  final int? weight;
  final ExtensionAttributesModel? extensionAttributes;
  final List<GroupOptionsModel>? groupOptions;

  final List<MediaGalleryEntryModel>? mediaGalleryEntries;

  final List<CustomAttributeModel>? customAttributes;

  ProductItemModel({
    this.id,
    this.sku,
    this.name,
    this.attributeSetId,
    this.price,
    this.status,
    this.visibility,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.weight,
    this.extensionAttributes,
    this.groupOptions,

    this.mediaGalleryEntries,

    this.customAttributes,
  });
}

class ExtensionAttributesModel {
  final List<int>? websiteIds;
  final List<CategoryLinkModel>? categoryLinks;
  final List<BundleProductOptionsModel>? bundleProductOptions;
  List<String>? codazonLabels;

  ExtensionAttributesModel({
    this.websiteIds,
    this.categoryLinks,
    this.bundleProductOptions,
    this.codazonLabels,
  });
}

class CategoryLinkModel {
  final int? position;
  final String? categoryId;

  CategoryLinkModel({
    this.position,
    this.categoryId,
  });
}

class MediaGalleryEntryModel {
  final int? id;
  final String? mediaType;

  final int? position;
  final bool? disabled;
  final List<String>? types;
  final String? file;

  MediaGalleryEntryModel({
    this.id,
    this.mediaType,

    this.position,
    this.disabled,
    this.types,
    this.file,
  });
}

class CustomAttributeModel {
  final String? attributeCode;
  final dynamic value;

  CustomAttributeModel({
    this.attributeCode,
    this.value,
  });
}

class SearchCriteriaModel {
  final List<FilterGroupModel>? filterGroups;

  final List<SortOrderModel>? sortOrders;

  SearchCriteriaModel({
    this.filterGroups,

    this.sortOrders,
  });
}

class FilterGroupModel {
  final List<FilterModel>? filters;

  FilterGroupModel({
    this.filters,
  });
}

class FilterModel {

  final String? value;
  final String? conditionType;

  FilterModel({

    this.value,
    this.conditionType,
  });
}

class SortOrderModel {
  final String? field;
  final String? direction;

  SortOrderModel({
    this.field,
    this.direction,
  });
}
