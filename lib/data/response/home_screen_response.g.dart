// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Screen _$ScreenFromJson(Map<String, dynamic> json) => Screen(
      screenId: json['screen_id'] as String,
      name: json['name'] as String,
      components: (json['components'] as List<dynamic>)
          .map((e) => Component.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScreenToJson(Screen instance) => <String, dynamic>{
      'screen_id': instance.screenId,
      'name': instance.name,
      'components': instance.components,
    };

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      componentId: json['component_id'] as String,
      screenId: json['screen_id'] as String,
      sortId: json['sort_id'] as String,
      type: json['type'] as String,
      componentData:
          const ComponentDataConverter().fromJson(json['component_data']),
      timer: (json['timer'] as num).toInt(),
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'component_id': instance.componentId,
      'screen_id': instance.screenId,
      'sort_id': instance.sortId,
      'type': instance.type,
      'component_data':
          const ComponentDataConverter().toJson(instance.componentData),
      'timer': instance.timer,
    };

SliderComponentData _$SliderComponentDataFromJson(Map<String, dynamic> json) =>
    SliderComponentData(
      image: json['image'] as String,
      categoryId: json['category_id'] as String,
    );

Map<String, dynamic> _$SliderComponentDataToJson(
        SliderComponentData instance) =>
    <String, dynamic>{
      'image': instance.image,
      'category_id': instance.categoryId,
    };

CategoryComponentData _$CategoryComponentDataFromJson(
        Map<String, dynamic> json) =>
    CategoryComponentData(
      categoryComponent: (json['component_data'] as List<dynamic>)
          .map((e) => CategoryComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryComponentDataToJson(
        CategoryComponentData instance) =>
    <String, dynamic>{
      'component_data': instance.categoryComponent,
    };

CategoryComponent _$CategoryComponentFromJson(Map<String, dynamic> json) =>
    CategoryComponent(
      title: json['title'] as String,
      categoryId: json['category_id'] as String,
      children: (json['children'] as List<dynamic>)
          .map((e) => CategoryChild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryComponentToJson(CategoryComponent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category_id': instance.categoryId,
      'children': instance.children,
    };

CategoryChild _$CategoryChildFromJson(Map<String, dynamic> json) =>
    CategoryChild(
      categoryId: json['category_id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CategoryChildToJson(CategoryChild instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'image': instance.image,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      specialPrice: json['special_price'] as String?,
      image: json['image'] as String,
      url: json['url'] as String,
      discount: json['discount'] as String,
      isWishlisted: json['is_wishlisted'] as String,
      sku: json['sku'] as String,
      salableQty: (json['salable_qty'] as num).toInt(),
      onSale: json['on_sale'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'special_price': instance.specialPrice,
      'image': instance.image,
      'url': instance.url,
      'discount': instance.discount,
      'is_wishlisted': instance.isWishlisted,
      'sku': instance.sku,
      'salable_qty': instance.salableQty,
      'on_sale': instance.onSale,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      label: json['label'] as String,
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
      'thumbnail': instance.thumbnail,
    };

BrandComponentData _$BrandComponentDataFromJson(Map<String, dynamic> json) =>
    BrandComponentData(
      title: json['title'] as String,
      type: json['type'] as String,
      featuredBrands: (json['featured_brands'] as List<dynamic>)
          .map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandComponentDataToJson(BrandComponentData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'featured_brands': instance.featuredBrands,
    };

ProductComponentData _$ProductComponentDataFromJson(
        Map<String, dynamic> json) =>
    ProductComponentData(
      title: json['title'] as String,
      collectionFilter: json['collection_filter'] as String,
      initialize: json['initialize'] as String?,
      newArrivalProducts: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductComponentDataToJson(
        ProductComponentData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'collection_filter': instance.collectionFilter,
      'initialize': instance.initialize,
      'products': instance.newArrivalProducts,
    };
