part of 'delete_address_bloc.dart';

sealed class DeleteAddressEvent extends Equatable {
  const DeleteAddressEvent();
}


class DeleteAddressButtonPressed extends DeleteAddressEvent {
  final int itemId;
  final String authorization;



  const DeleteAddressButtonPressed({required this.itemId,required this.authorization});

  @override
  List<Object> get props => [itemId,authorization];
}