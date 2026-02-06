import 'package:json_annotation/json_annotation.dart';

part 'bundle_product_options_response.g.dart';

@JsonSerializable()
class BundleProductOptionsResponse {
  @JsonKey(name: "option_id")
  final int? optionId;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "required")
  final bool? required;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "position")
  final int? position;
  @JsonKey(name: "sku")
  final String? sku;
  @JsonKey(name: "product_links")
  final List<ProductLinks>? productLinks;

  BundleProductOptionsResponse ({
    this.optionId,
    this.title,
    this.required,
    this.type,
    this.position,
    this.sku,
    this.productLinks,
  });

  factory BundleProductOptionsResponse.fromJson(Map<String, dynamic> json) {
    return _$BundleProductOptionsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BundleProductOptionsResponseToJson(this);
  }
}

@JsonSerializable()
class ProductLinks {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "sku")
  final String? sku;
  @JsonKey(name: "option_id")
  final int? optionId;
  @JsonKey(name: "qty")
  final int? qty;
  @JsonKey(name: "position")
  final int? position;
  @JsonKey(name: "is_default")
  final bool? isDefault;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "price_type")
  final int? priceType;
  @JsonKey(name: "can_change_quantity")
  final int? canChangeQuantity;

  ProductLinks ({
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

  factory ProductLinks.fromJson(Map<String, dynamic> json) {
    return _$ProductLinksFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductLinksToJson(this);
  }
}


