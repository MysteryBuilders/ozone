part of 'addresses_bloc.dart';

sealed class AddressesEvent extends Equatable {
  const AddressesEvent();
}

class AddressesFetched extends AddressesEvent {
  final String authorization;
  final int index;


  const AddressesFetched(this.authorization,this.index);

  @override
  List<Object> get props => [Random().nextDouble(),authorization,this.index];
}