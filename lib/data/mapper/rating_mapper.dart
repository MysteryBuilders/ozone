import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/rating_response.dart';
import 'package:ozon/domain/model/rating_model.dart';

import '../../app/constants.dart';

extension RatingResponseMapper on RatringResponse? {
  RatingModel toDomain() {
    return RatingModel(
      id: this?.id ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      detail: this?.detail.orEmpty() ?? Constants.empty,
      nickname: this?.nickname.orEmpty() ?? Constants.empty,
      customerId: this?.customerId ?? Constants.zero,
      ratings: this?.ratings ?? [],
      reviewEntity: this?.reviewEntity.orEmpty() ?? Constants.empty,
      reviewType: this?.reviewType ?? Constants.zero,
      reviewStatus: this?.reviewStatus ?? Constants.zero,
      createdAt: this?.createdAt.orEmpty() ?? Constants.empty,
      entityPkValue: this?.entityPkValue ?? Constants.zero,
      storeId: this?.storeId ?? Constants.zero,
      stores: this?.stores ?? [],
    );
  }
}
