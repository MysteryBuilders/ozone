part of 'promo_bloc.dart';

sealed class PromoState extends Equatable {
  const PromoState();
}

final class PromoInitial extends PromoState {
  @override
  List<Object> get props => [];
}

class PromoLoading extends PromoState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class PromoSuccess extends PromoState {
  final PromoModel promoModel;

  const PromoSuccess({required this.promoModel});

  @override
  List<Object> get props => [promoModel];
}

class PromoFailure extends PromoState {
  final String message;

  const PromoFailure({required this.message});

  @override
  List<Object> get props => [message];
}