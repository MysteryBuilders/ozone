part of 'categories_home_bloc.dart';

sealed class CategoriesHomeEvent extends Equatable {
  const CategoriesHomeEvent();
}
class CategoriesHomeFetched extends CategoriesHomeEvent {
  final String authorization;


  const CategoriesHomeFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}