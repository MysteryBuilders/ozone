part of 'stock_info_bloc.dart';

@immutable
sealed class StockInfoState {}

final class StockInfoInitial extends StockInfoState {}



class StockInfoLoading extends StockInfoState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class StockInfoSuccess extends StockInfoState {
  final CheckStockModel stockModel;

   StockInfoSuccess({required this.stockModel});

  @override
  List<Object> get props => [stockModel];
}

class StockInfoFailure extends StockInfoState {
  final String message;

   StockInfoFailure({required this.message});

  @override
  List<Object> get props => [message];
}

