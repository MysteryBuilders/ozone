import 'package:ozon/domain/model/product_model.dart';

import '../../../../domain/model/products_model.dart';

abstract class LoadMoreState {}
class initalLoading extends LoadMoreState {

}
class DataLoading extends LoadMoreState {

}

class DataLoaded extends LoadMoreState {
  final List<ProductItemModel> items;
  final bool hasReachedMax;

  DataLoaded({required this.items, this.hasReachedMax = false});
}

class DataError extends LoadMoreState {
  final String message;

   DataError({required this.message});

  @override
  List<Object> get props => [message];
}
