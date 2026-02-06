part of 'add_address_bloc.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();
}

final class AddAddressInitial extends AddAddressState {
  @override
  List<Object> get props => [];
}
class AddAddressLoading extends AddAddressState {
  final int index;
  const AddAddressLoading({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class AddAddressSuccess extends AddAddressState {
  final CustomerDomain customerDomain;
  final int index;

  const AddAddressSuccess({required this.customerDomain,required this.index});

  @override
  List<Object> get props => [customerDomain,index];
}

class AddAddressFailure extends AddAddressState {
  final String message;
  final int index;
  const AddAddressFailure({required this.message,required this.index});

  @override
  List<Object> get props => [message,index];
}

