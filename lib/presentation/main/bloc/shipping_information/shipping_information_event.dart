part of 'shipping_information_bloc.dart';

sealed class ShippingInformationEvent extends Equatable {
  const ShippingInformationEvent();
}

class ShippingInformationFetched extends ShippingInformationEvent {

  final String authorization;
  final Map<String,dynamic> map;


  const ShippingInformationFetched(this.authorization,this.map);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,map];
}