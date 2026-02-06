// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatringResponse _$RatringResponseFromJson(Map<String, dynamic> json) =>
    RatringResponse(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      detail: json['detail'] as String?,
      nickname: json['nickname'] as String?,
      customerId: (json['customer_id'] as num?)?.toInt(),
      ratings: json['ratings'] as List<dynamic>?,
      reviewEntity: json['review_entity'] as String?,
      reviewType: (json['review_type'] as num?)?.toInt(),
      reviewStatus: (json['review_status'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      entityPkValue: (json['entity_pk_value'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RatringResponseToJson(RatringResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
      'nickname': instance.nickname,
      'customer_id': instance.customerId,
      'ratings': instance.ratings,
      'review_entity': instance.reviewEntity,
      'review_type': instance.reviewType,
      'review_status': instance.reviewStatus,
      'created_at': instance.createdAt,
      'entity_pk_value': instance.entityPkValue,
      'store_id': instance.storeId,
      'stores': instance.stores,
    };
