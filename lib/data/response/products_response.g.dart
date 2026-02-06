// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponse _$ProductsResponseFromJson(Map<String, dynamic> json) =>
    ProductsResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      searchCriteria: json['search_criteria'] == null
          ? null
          : SearchCriteria.fromJson(
              json['search_criteria'] as Map<String, dynamic>),
      totalCount: (json['total_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'search_criteria': instance.searchCriteria,
      'total_count': instance.totalCount,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: (json['id'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      attributeSetId: (json['attribute_set_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      visibility: (json['visibility'] as num?)?.toInt(),
      typeId: json['type_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      extensionAttributes: json['extension_attributes'] == null
          ? null
          : ExtensionAttributes.fromJson(
              json['extension_attributes'] as Map<String, dynamic>),
      productLinks: (json['product_links'] as List<dynamic>?)
          ?.map((e) => GroupOptionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaGalleryEntries: (json['media_gallery_entries'] as List<dynamic>?)
          ?.map((e) => MediaGalleryEntries.fromJson(e as Map<String, dynamic>))
          .toList(),
      customAttributes: (json['custom_attributes'] as List<dynamic>?)
          ?.map((e) => CustomAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'attribute_set_id': instance.attributeSetId,
      'price': instance.price,
      'status': instance.status,
      'visibility': instance.visibility,
      'type_id': instance.typeId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'weight': instance.weight,
      'extension_attributes': instance.extensionAttributes,
      'product_links': instance.productLinks,
      'media_gallery_entries': instance.mediaGalleryEntries,
      'custom_attributes': instance.customAttributes,
    };

ExtensionAttributes _$ExtensionAttributesFromJson(Map<String, dynamic> json) =>
    ExtensionAttributes(
      websiteIds: (json['website_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      categoryLinks: (json['category_links'] as List<dynamic>?)
          ?.map((e) => CategoryLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleProductOptions: (json['bundle_product_options'] as List<dynamic>?)
          ?.map((e) =>
              BundleProductOptionsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      codazonLabels: (json['codazon_labels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ExtensionAttributesToJson(
        ExtensionAttributes instance) =>
    <String, dynamic>{
      'website_ids': instance.websiteIds,
      'category_links': instance.categoryLinks,
      'bundle_product_options': instance.bundleProductOptions,
      'codazon_labels': instance.codazonLabels,
    };

CategoryLinks _$CategoryLinksFromJson(Map<String, dynamic> json) =>
    CategoryLinks(
      position: (json['position'] as num?)?.toInt(),
      categoryId: json['category_id'] as String?,
    );

Map<String, dynamic> _$CategoryLinksToJson(CategoryLinks instance) =>
    <String, dynamic>{
      'position': instance.position,
      'category_id': instance.categoryId,
    };

MediaGalleryEntries _$MediaGalleryEntriesFromJson(Map<String, dynamic> json) =>
    MediaGalleryEntries(
      id: (json['id'] as num?)?.toInt(),
      mediaType: json['media_type'] as String?,
      position: (json['position'] as num?)?.toInt(),
      disabled: json['disabled'] as bool?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      file: json['file'] as String?,
    );

Map<String, dynamic> _$MediaGalleryEntriesToJson(
        MediaGalleryEntries instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': instance.mediaType,
      'position': instance.position,
      'disabled': instance.disabled,
      'types': instance.types,
      'file': instance.file,
    };

CustomAttributes _$CustomAttributesFromJson(Map<String, dynamic> json) =>
    CustomAttributes(
      attributeCode: json['attribute_code'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$CustomAttributesToJson(CustomAttributes instance) =>
    <String, dynamic>{
      'attribute_code': instance.attributeCode,
      'value': instance.value,
    };

SearchCriteria _$SearchCriteriaFromJson(Map<String, dynamic> json) =>
    SearchCriteria(
      filterGroups: (json['filter_groups'] as List<dynamic>?)
          ?.map((e) => FilterGroups.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortOrders: (json['sort_orders'] as List<dynamic>?)
          ?.map((e) => SortOrders.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchCriteriaToJson(SearchCriteria instance) =>
    <String, dynamic>{
      'filter_groups': instance.filterGroups,
      'sort_orders': instance.sortOrders,
    };

FilterGroups _$FilterGroupsFromJson(Map<String, dynamic> json) => FilterGroups(
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filters.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterGroupsToJson(FilterGroups instance) =>
    <String, dynamic>{
      'filters': instance.filters,
    };

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      field: json['field'] as String?,
      value: json['value'] as String?,
      conditionType: json['condition_type'] as String?,
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'field': instance.field,
      'value': instance.value,
      'condition_type': instance.conditionType,
    };

SortOrders _$SortOrdersFromJson(Map<String, dynamic> json) => SortOrders(
      direction: json['direction'] as String?,
    );

Map<String, dynamic> _$SortOrdersToJson(SortOrders instance) =>
    <String, dynamic>{
      'direction': instance.direction,
    };
