part of 'promo_bloc.dart';

sealed class PromoEvent extends Equatable {
  const PromoEvent();
}
class PromoFetched extends PromoEvent {

  final String authorization;



  const PromoFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}