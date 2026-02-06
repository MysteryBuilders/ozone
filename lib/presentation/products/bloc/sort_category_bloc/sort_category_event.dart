part of 'sort_category_bloc.dart';

sealed class SortCategoryEvent extends Equatable {
  const SortCategoryEvent();
}

class SortCategoryFetched extends SortCategoryEvent {
 int categoryId;
  String authorization;



 SortCategoryFetched(this.categoryId,this.authorization);

  @override
  List<Object> get props => [categoryId,authorization];
}

class SortCategorySelect extends SortCategoryEvent {

 SortingOptionModel sortingOptionModel;
 int position;



 SortCategorySelect(this.sortingOptionModel,this.position);

 @override
 List<Object> get props => [sortingOptionModel,this.position];
}
class SortBySelect extends SortCategoryEvent {

 String sortBy;




 SortBySelect(this.sortBy);

 @override
 List<Object> get props => [sortBy];
}
class filterFetch extends SortCategoryEvent {

Map<String,dynamic> filterMap;




 filterFetch(this.filterMap);

 @override
 List<Object> get props => [filterMap];
}


