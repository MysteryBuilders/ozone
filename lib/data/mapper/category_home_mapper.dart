import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';

import '../../domain/model/category_home_model.dart';
import '../response/category_home_response.dart';

extension CategoryItemMapper on CategoryItem?{
  CategroyItemModel toDomain(){
    return CategroyItemModel(categoryId:this?.categoryId.orEmpty()??Constants.empty,
       categoryImage: this?.categoryImage.orEmpty()??Constants.empty);

  }

}
extension SearchCriteriaMapper on SearchCriteria?{
  SearchCriteriaModel toDomain(){
    return SearchCriteriaModel(filterGroups: [],
        pageSize: this?.pageSize.orZero()??Constants.zero);

  }

}
extension CategoryHomeResponseMapper on CategoryHomeResponse?{
  List<CategroyItemModel> get categoryList {
    return (this?.items
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<CategroyItemModel>()
        .toList();
  }
  CategoryHomeModel toDomain(){
    return CategoryHomeModel(items: categoryList,
    searchCriteria: this!.searchCriteria.toDomain(),
    totalCount: this?.totalCount.orZero()??Constants.zero);

  }

}