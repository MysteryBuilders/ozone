part of 'stock_info_bloc.dart';

@immutable
sealed class StockInfoEvent {}

class StockInfoFetched extends StockInfoEvent {
  String sku;
  String authorization;



  StockInfoFetched(this.sku,this.authorization);

  @override
  List<Object> get props => [sku,authorization];
}
