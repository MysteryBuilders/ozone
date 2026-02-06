part of 'my_orders_bloc.dart';

sealed class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();
}
class MyOrdersFetched extends MyOrdersEvent {
  Map<String,dynamic> map;
  String authorization;



  MyOrdersFetched(this.map,this.authorization);

  @override
  List<Object> get props => [map];
}