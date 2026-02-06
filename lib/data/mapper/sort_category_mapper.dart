import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/sorting_category_response.dart';
import 'package:ozon/domain/model/sorting_category_model.dart';

import '../../app/constants.dart';

extension SortingOptionResponseMapper on SortingOptionResponse?{
  SortingOptionModel toDomain(){
    return SortingOptionModel(this?.sortName.orEmpty()??Constants.empty,
        this?.sortCode.orEmpty()??Constants.empty,
        );

  }

}

extension FilterOptionMapper on FilterOption?{
  FilterOptionModel toDomain(){
    return FilterOptionModel(this?.name.orEmpty()??Constants.empty,
      this?.filterId.orEmpty()??Constants.empty,
      this?.count.orZero()??Constants.zero,
    );

  }

}

extension AvailableFilterMapper on AvailableFilter?{
  List<FilterOptionModel> get filterOptionList {
    return (this?.options
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<FilterOptionModel>()
        .toList();
  }

  AvailableFilterModel toDomain() {
    return AvailableFilterModel(this?.filterName.orEmpty()??Constants.empty,
        this?.filterCode.orEmpty()??Constants.empty,
        this?.filterType.orEmpty()??Constants.empty,filterOptionList,
      this?.minPrice.orZero()??Constants.zero,
      this?.maxPrice.orZero()??Constants.zero,
    );
  }
}
extension SortingCategoryResponseMapper on SortingCategoryResponse?{
  List<SortingOptionModel> get sortList {
    return (this?.sortList
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<SortingOptionModel>()
        .toList();
  }
  List<AvailableFilterModel> get availableFilterList {
    return (this?.availableFilter
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<AvailableFilterModel>()
        .toList();
  }
  SortingCategoryModel toDomain(){
    return SortingCategoryModel(sortList,availableFilterList);

  }

}