part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();
}
class ProductsFetched extends ProductsEvent {
  Map<String,dynamic> map;
  String authorization;



   ProductsFetched(this.map,this.authorization);

  @override
  List<Object> get props => [map];
}