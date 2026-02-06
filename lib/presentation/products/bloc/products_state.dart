part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class ProductsSuccess extends ProductsState {
  final ProductsModel productsModel;

  const ProductsSuccess({required this.productsModel});

  @override
  List<Object> get props => [productsModel];
}

class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
