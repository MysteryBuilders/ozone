part of 'apply_coupon_bloc.dart';

sealed class ApplyCouponEvent extends Equatable {
  const ApplyCouponEvent();
}

class ApplyCouponFetched extends ApplyCouponEvent {
  String coupoun;
  String authorization;



  ApplyCouponFetched(this.coupoun,this.authorization);

  @override
  List<Object> get props => [coupoun,authorization];
}
