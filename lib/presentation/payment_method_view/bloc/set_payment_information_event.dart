part of 'set_payment_information_bloc.dart';

sealed class SetPaymentInformationEvent extends Equatable {
  const SetPaymentInformationEvent();
}
class setPaymentInformationFetched extends SetPaymentInformationEvent {
  final String authorization;
  Map<String,dynamic> map;
  final int index;



  setPaymentInformationFetched(this.authorization,this.map,this.index);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,map,index];
}