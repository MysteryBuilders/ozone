part of 'check_out_bloc.dart';

sealed class CheckOutState extends Equatable {
  const CheckOutState();
}

final class CheckOutInitial extends CheckOutState {
  @override
  List<Object> get props => [];
}
class CheckOutLoading extends CheckOutState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckOutSuccess extends CheckOutState {
  final CheckOutModel checkOutModel;

  const CheckOutSuccess({required this.checkOutModel});

  @override
  List<Object> get props => [checkOutModel];
}

class CheckOutFailure extends CheckOutState {
  final String message;

  const CheckOutFailure({required this.message});

  @override
  List<Object> get props => [message];
}