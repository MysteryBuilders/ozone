part of 'shipping_information_bloc.dart';

sealed class ShippingInformationState extends Equatable {
  const ShippingInformationState();
}

final class ShippingInformationInitial extends ShippingInformationState {
  @override
  List<Object> get props => [];
}

class ShippingInformationLoading extends ShippingInformationState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class ShippingInformationSuccess extends ShippingInformationState {
  final ShippingInformationModel shippingInformationModel;

  const ShippingInformationSuccess({required this.shippingInformationModel});

  @override
  List<Object> get props => [shippingInformationModel];
}

class ShippingInformationFailure extends ShippingInformationState {
  final String message;

  const ShippingInformationFailure({required this.message});

  @override
  List<Object> get props => [message];
}