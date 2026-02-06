import 'package:json_annotation/json_annotation.dart';

part 'rating_response.g.dart';

@JsonSerializable()
class RatringResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "detail")
  final String? detail;
  @JsonKey(name: "nickname")
  final String? nickname;
  @JsonKey(name: "customer_id")
  final int? customerId;
  @JsonKey(name: "ratings")
  final List<dynamic>? ratings;
  @JsonKey(name: "review_entity")
  final String? reviewEntity;
  @JsonKey(name: "review_type")
  final int? reviewType;
  @JsonKey(name: "review_status")
  final int? reviewStatus;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "entity_pk_value")
  final int? entityPkValue;
  @JsonKey(name: "store_id")
  final int? storeId;
  @JsonKey(name: "stores")
  final List<int>? stores;

  RatringResponse ({
    this.id,
    this.title,
    this.detail,
    this.nickname,
    this.customerId,
    this.ratings,
    this.reviewEntity,
    this.reviewType,
    this.reviewStatus,
    this.createdAt,
    this.entityPkValue,
    this.storeId,
    this.stores,
  });

  factory RatringResponse.fromJson(Map<String, dynamic> json) {
    return _$RatringResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RatringResponseToJson(this);
  }
}


