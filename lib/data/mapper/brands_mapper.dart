import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/domain/model/brands_model.dart';

import '../response/brands_response.dart';

extension BrandItemResponseMapper on BrandItemResponse?{
  BrandItemModel toDomain(){
    return BrandItemModel(this?.brand_id.orEmpty()??Constants.empty,
        this?.brand_name.orEmpty()??Constants.empty,
        this?.brand_img.orEmpty()??Constants.empty,
        this?.products_count.orZero()??Constants.zero);

  }

}

extension BrandsDataResponseMapper on BrandsDataResponse?{
  List<BrandItemModel> get brandsList {
    return (this?.brandsList
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<BrandItemModel>()
        .toList();
  }
  BrandsDataModel toDomain(){
    return BrandsDataModel(this?.title.orEmpty()??Constants.empty,
    brandsList);

  }

}