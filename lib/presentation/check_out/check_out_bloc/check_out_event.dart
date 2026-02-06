part of 'check_out_bloc.dart';

sealed class CheckOutEvent extends Equatable {
  const CheckOutEvent();
}

class CheckOutFetched extends CheckOutEvent {

  final   String authorization;


  const CheckOutFetched({required this.authorization});

  @override
  List<Object> get props => [authorization];
}