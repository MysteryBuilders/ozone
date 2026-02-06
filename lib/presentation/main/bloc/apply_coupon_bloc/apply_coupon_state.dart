part of 'apply_coupon_bloc.dart';

sealed class ApplyCouponState extends Equatable {
  const ApplyCouponState();
}

final class ApplyCouponInitial extends ApplyCouponState {
  @override
  List<Object> get props => [];
}
class ApplyCouponLoading extends ApplyCouponState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class ApplyCouponSuccess extends ApplyCouponState {
  final bool isSuccess;

  ApplyCouponSuccess({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}

class ApplyCouponFailure extends ApplyCouponState {
  final String message;

  ApplyCouponFailure({required this.message});

  @override
  List<Object> get props => [message];
}


