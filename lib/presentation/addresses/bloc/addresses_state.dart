part of 'addresses_bloc.dart';

sealed class AddressesState extends Equatable {
  const AddressesState();
}

final class AddressesInitial extends AddressesState {
  @override
  List<Object> get props => [];
}

class AddressesLoading extends AddressesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddressesSuccess extends AddressesState {
  final CustomerDomain customerDomain;

  const AddressesSuccess({required this.customerDomain});

  @override
  List<Object> get props => [customerDomain];
}

class AddressesFailure extends AddressesState {
  final String message;

  const AddressesFailure({required this.message});

  @override
  List<Object> get props => [message];
}

