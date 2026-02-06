part of 'add_address_bloc.dart';

sealed class AddAddressEvent extends Equatable {
  const AddAddressEvent();
}
class AddAddressFetched extends AddAddressEvent {
  final String authorization;
  final int index;
  final Map<String,dynamic> map;


  const AddAddressFetched(this.map,this.authorization,this.index);

  @override
  List<Object> get props => [Random().nextDouble(),map,authorization,this.index];
}