part of 'sort_category_bloc.dart';

sealed class SortCategoryState extends Equatable {
  const SortCategoryState();
}

final class SortCategoryInitial extends SortCategoryState {
  @override
  List<Object> get props => [];
}

class SortCategoryLoading extends SortCategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class SortCategorySuccess extends SortCategoryState {
  final SortingCategoryModel sortingCategoryModel;
  final SortingOptionModel sortingOptionModel;
  final int position;
  final String sortBy;
  final Map<String,dynamic> filterMap;

  const SortCategorySuccess({required this.sortingCategoryModel,required this.sortingOptionModel,required this.position,required this.sortBy
 , required this.filterMap});

  @override
  List<Object> get props => [sortingCategoryModel,position,sortingOptionModel,sortBy,filterMap,Random().nextDouble()];
}

class SortCategoryFailure extends SortCategoryState {
  final String message;

  const SortCategoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}