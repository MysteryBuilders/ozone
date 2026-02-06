import 'package:json_annotation/json_annotation.dart';
import 'package:ozon/data/response/bundle_product_options_response.dart';
import 'package:ozon/data/response/group_option_response.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: "items")
  final List<Items>? items;
  @JsonKey(name: "search_criteria")
  final SearchCriteria? searchCriteria;
  @JsonKey(name: "total_count")
  final int? totalCount;

  ProductsResponse ({
    this.items,
    this.searchCriteria,
    this.totalCount,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseToJson(this);
  }
}

@JsonSerializable()
class Items {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "sku")
  final String? sku;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "attribute_set_id")
  final int? attributeSetId;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "visibility")
  final int? visibility;
  @JsonKey(name: "type_id")
  final String? typeId;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "weight")
  final int? weight;
  @JsonKey(name: "extension_attributes")
  final ExtensionAttributes? extensionAttributes;
  @JsonKey(name: "product_links")
  final List<GroupOptionResponse>? productLinks;


  @JsonKey(name: "media_gallery_entries")
  final List<MediaGalleryEntries>? mediaGalleryEntries;

  @JsonKey(name: "custom_attributes")
  final List<CustomAttributes>? customAttributes;

  Items ({
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
    this.productLinks,

    this.mediaGalleryEntries,

    this.customAttributes,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return _$ItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ItemsToJson(this);
  }
}

@JsonSerializable()
class ExtensionAttributes {
  @JsonKey(name: "website_ids")
  final List<int>? websiteIds;
  @JsonKey(name: "category_links")
  final List<CategoryLinks>? categoryLinks;
  @JsonKey(name: "bundle_product_options")
  final List<BundleProductOptionsResponse>? bundleProductOptions;
  @JsonKey(name: "codazon_labels")
  final List<String>? codazonLabels;
  ExtensionAttributes ({
    this.websiteIds,
    this.categoryLinks,
    this.bundleProductOptions,
    this.codazonLabels
  });

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return _$ExtensionAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExtensionAttributesToJson(this);
  }
}

@JsonSerializable()
class CategoryLinks {
  @JsonKey(name: "position")
  final int? position;
  @JsonKey(name: "category_id")
  final String? categoryId;

  CategoryLinks ({
    this.position,
    this.categoryId,
  });

  factory CategoryLinks.fromJson(Map<String, dynamic> json) {
    return _$CategoryLinksFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryLinksToJson(this);
  }
}

@JsonSerializable()
class MediaGalleryEntries {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "media_type")
  final String? mediaType;

  @JsonKey(name: "position")
  final int? position;
  @JsonKey(name: "disabled")
  final bool? disabled;
  @JsonKey(name: "types")
  final List<String>? types;
  @JsonKey(name: "file")
  final String? file;

  MediaGalleryEntries ({
    this.id,
    this.mediaType,

    this.position,
    this.disabled,
    this.types,
    this.file,
  });

  factory MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    return _$MediaGalleryEntriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MediaGalleryEntriesToJson(this);
  }
}

@JsonSerializable()
class CustomAttributes {
  @JsonKey(name: "attribute_code")
  final String? attributeCode;
  @JsonKey(name: "value")
  final dynamic value;

  CustomAttributes ({
    this.attributeCode,
    this.value,
  });

  factory CustomAttributes.fromJson(Map<String, dynamic> json) {
    return _$CustomAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CustomAttributesToJson(this);
  }
}

@JsonSerializable()
class SearchCriteria {
  @JsonKey(name: "filter_groups")
  final List<FilterGroups>? filterGroups;
  @JsonKey(name: "sort_orders")
  final List<SortOrders>? sortOrders;

  SearchCriteria ({
    this.filterGroups,
    this.sortOrders,
  });

  factory SearchCriteria.fromJson(Map<String, dynamic> json) {
    return _$SearchCriteriaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchCriteriaToJson(this);
  }
}

@JsonSerializable()
class FilterGroups {
  @JsonKey(name: "filters")
  final List<Filters>? filters;

  FilterGroups ({
    this.filters,
  });

  factory FilterGroups.fromJson(Map<String, dynamic> json) {
    return _$FilterGroupsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FilterGroupsToJson(this);
  }
}

@JsonSerializable()
class Filters {
  @JsonKey(name: "field")
  final String? field;
  @JsonKey(name: "value")
  final String? value;
  @JsonKey(name: "condition_type")
  final String? conditionType;

  Filters ({
    this.field,
    this.value,
    this.conditionType,
  });

  factory Filters.fromJson(Map<String, dynamic> json) {
    return _$FiltersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FiltersToJson(this);
  }
}

@JsonSerializable()
class SortOrders {

  @JsonKey(name: "direction")
  final String? direction;

  SortOrders ({

    this.direction,
  });

  factory SortOrders.fromJson(Map<String, dynamic> json) {
    return _$SortOrdersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SortOrdersToJson(this);
  }
}


