part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderFetched extends OrderEvent {
  final String authorization;
  Map<String,dynamic> map;


  OrderFetched(this.authorization,this.map);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,map];
}