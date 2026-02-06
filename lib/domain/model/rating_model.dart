class RatingModel {
  final int? id;
  final String? title;
  final String? detail;
  final String? nickname;
  final int? customerId;
  final List<dynamic>? ratings;
  final String? reviewEntity;
  final int? reviewType;
  final int? reviewStatus;
  final String? createdAt;
  final int? entityPkValue;
  final int? storeId;
  final List<int>? stores;

  RatingModel({
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
}
