part of 'create_cart_bloc.dart';

sealed class CreateCartEvent extends Equatable {
  const CreateCartEvent();
}
class CreateCartFetched extends CreateCartEvent {
  final String authorization;


  const CreateCartFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}