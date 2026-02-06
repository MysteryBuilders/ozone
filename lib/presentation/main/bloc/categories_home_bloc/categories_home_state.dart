part of 'categories_home_bloc.dart';

sealed class CategoriesHomeState extends Equatable {
  const CategoriesHomeState();
}

final class CategoriesHomeInitial extends CategoriesHomeState {
  @override
  List<Object> get props => [];
}
class CategoriesHomeLoading extends CategoriesHomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class CategoriesHomeSuccess extends CategoriesHomeState {
  final CategoryHomeModel categoryHomeModel;

  const CategoriesHomeSuccess({required this.categoryHomeModel});

  @override
  List<Object> get props => [categoryHomeModel];
}

class CategoriesHomeFailure extends CategoriesHomeState {
  final String message;

  const CategoriesHomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}