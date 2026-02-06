part of 'delete_address_bloc.dart';

sealed class DeleteAddressState extends Equatable {
  const DeleteAddressState();
}

final class DeleteAddressInitial extends DeleteAddressState {
  @override
  List<Object> get props => [];
}
class DeleteAddressLoading extends DeleteAddressState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class DeleteAddressSuccess extends DeleteAddressState {
  final bool success;

  const DeleteAddressSuccess({required this.success});

  @override
  List<Object> get props => [success];
}

class DeleteAddressFailure extends DeleteAddressState {
  final String message;

  const DeleteAddressFailure({required this.message});

  @override
  List<Object> get props => [message];
}

