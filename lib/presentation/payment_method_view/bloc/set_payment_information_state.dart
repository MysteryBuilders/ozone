part of 'set_payment_information_bloc.dart';

sealed class SetPaymentInformationState extends Equatable {
  const SetPaymentInformationState();
}

final class SetPaymentInformationInitial extends SetPaymentInformationState {
  @override
  List<Object> get props => [];
}

class SetPaymentInformationLoading extends SetPaymentInformationState {
  final int index;

  const SetPaymentInformationLoading({required this.index});

  @override
  List<Object> get props => [index];

}

class SetPaymentInformationSuccess extends SetPaymentInformationState {
  final bool code;
  final int index;

  const SetPaymentInformationSuccess({required this.code,required this.index});

  @override
  List<Object> get props => [code,index];
}

class SetPaymentInformationFailure extends SetPaymentInformationState {
  final String message;
  final int index;

  const SetPaymentInformationFailure({required this.message,required this.index});

  @override
  List<Object> get props => [message,index];
}