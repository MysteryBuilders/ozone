import 'package:json_annotation/json_annotation.dart';

import 'component_data_converter.dart';

part 'home_screen_response.g.dart';

// Root model
@JsonSerializable()
class Screen {
  @JsonKey(name: 'screen_id')
  final String screenId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'components')
  final List<Component> components;

  Screen({required this.screenId, required this.name, required this.components});

  factory Screen.fromJson(Map<String, dynamic> json) => _$ScreenFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenToJson(this);
}

// Component model
@JsonSerializable()
class Component {
  @JsonKey(name: 'component_id')
  final String componentId;

  @JsonKey(name: 'screen_id')
  final String screenId;

  @JsonKey(name: 'sort_id')
  final String sortId;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'component_data')
  @ComponentDataConverter()
  final dynamic componentData;

  @JsonKey(name: 'timer')
  final int timer;

  Component({
    required this.componentId,
    required this.screenId,
    required this.sortId,
    required this.type,
    required this.componentData,
    required this.timer
  });

  factory Component.fromJson(Map<String, dynamic> json) => _$ComponentFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}

// Slider component data
@JsonSerializable()
class SliderComponentData {
  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'category_id')
  final String categoryId;

  SliderComponentData({required this.image, required this.categoryId});

  factory SliderComponentData.fromJson(Map<String, dynamic> json) => _$SliderComponentDataFromJson(json);
  Map<String, dynamic> toJson() => _$SliderComponentDataToJson(this);
}

// Category component
@JsonSerializable()
class CategoryComponentData {
  @JsonKey(name: 'component_data')
  final List<CategoryComponent> categoryComponent;

  CategoryComponentData({required this.categoryComponent});

  factory CategoryComponentData.fromJson(Map<String, dynamic> json) => _$CategoryComponentDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryComponentDataToJson(this);
}

@JsonSerializable()
class CategoryComponent {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'category_id')
  final String categoryId;

  @JsonKey(name: 'children')
  final List<CategoryChild> children;

  CategoryComponent({required this.title, required this.categoryId, required this.children});

  factory CategoryComponent.fromJson(Map<String, dynamic> json) => _$CategoryComponentFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryComponentToJson(this);
}

@JsonSerializable()
class CategoryChild {
  @JsonKey(name: 'category_id')
  final String categoryId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'image')
  final String? image;

  CategoryChild({required this.categoryId, required this.name, required this.image});

  factory CategoryChild.fromJson(Map<String, dynamic> json) => _$CategoryChildFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryChildToJson(this);
}

// Best Seller Product Model
@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  final String productId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'price')
  final String price;

  @JsonKey(name: 'special_price')
  final String? specialPrice;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'discount')
  final String discount;

  @JsonKey(name: 'is_wishlisted')
  final String isWishlisted;

  @JsonKey(name: 'sku')
  final String sku;
  @JsonKey(name: 'salable_qty')
  final int salableQty;
  @JsonKey(name: 'on_sale')
  final String onSale;

  Product({
    required this.productId,
    required this.name,
    required this.price,
    this.specialPrice,
    required this.image,
    required this.url,
    required this.discount,
    required this.isWishlisted,
    required this.sku,
    required this.salableQty,
    required this.onSale
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// Brand model
@JsonSerializable()
class Brand {
  @JsonKey(name: 'label')
  final String label;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  Brand({required this.label, required this.url, required this.thumbnail});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}



@JsonSerializable()
class BrandComponentData {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'featured_brands')
  final List<Brand> featuredBrands;

  BrandComponentData({
    required this.title,
    required this.type,
    required this.featuredBrands,
  });

  factory BrandComponentData.fromJson(Map<String, dynamic> json) =>
      _$BrandComponentDataFromJson(json);
  Map<String, dynamic> toJson() => _$BrandComponentDataToJson(this);
}


@JsonSerializable()
class ProductComponentData {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'collection_filter')
  final String collectionFilter;
  @JsonKey(name: 'initialize')
  final String? initialize;

  // @JsonKey(name: 'products')
  // final List<Product>? bestSellerProducts;
  //
  // @JsonKey(name: 'products')
  // final List<Product>? offersProducts;

  @JsonKey(name: 'products')
  final List<Product>? newArrivalProducts;

  ProductComponentData({
    required this.title,
    required this.collectionFilter,
    this.initialize,
    // this.bestSellerProducts,
    // this.offersProducts,
    this.newArrivalProducts,
  });

  factory ProductComponentData.fromJson(Map<String, dynamic> json) => _$ProductComponentDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductComponentDataToJson(this);
}






