import 'package:json_annotation/json_annotation.dart';

part 'group_option_response.g.dart';

@JsonSerializable()
class GroupOptionResponse {
  @JsonKey(name: "sku")
  final String? sku;
  @JsonKey(name: "link_type")
  final String? linkType;
  @JsonKey(name: "linked_product_sku")
  final String? linkedProductSku;
  @JsonKey(name: "linked_product_type")
  final String? linkedProductType;
  @JsonKey(name: "position")
  final int? position;
  @JsonKey(name: "extension_attributes")
  final ExtensionAttributes? extensionAttributes;

  GroupOptionResponse ({
    this.sku,
    this.linkType,
    this.linkedProductSku,
    this.linkedProductType,
    this.position,
    this.extensionAttributes,
  });

  factory GroupOptionResponse.fromJson(Map<String, dynamic> json) {
    return _$GroupOptionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GroupOptionResponseToJson(this);
  }
}

@JsonSerializable()
class ExtensionAttributes {
  @JsonKey(name: "qty")
  final int? qty;

  ExtensionAttributes ({
    this.qty,
  });

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return _$ExtensionAttributesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExtensionAttributesToJson(this);
  }
}


