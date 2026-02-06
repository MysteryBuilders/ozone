part of 'estimate_method_bloc.dart';

sealed class EstimateMethodState extends Equatable {
  const EstimateMethodState();
}

final class EstimateMethodInitial extends EstimateMethodState {
  @override
  List<Object> get props => [];
}

class EstimateMethodLoading extends EstimateMethodState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class EstimateMethodSuccess extends EstimateMethodState {
  final List<EstimateShippingMethod> estimateMethodList;

  const EstimateMethodSuccess({required this.estimateMethodList});

  @override
  List<Object> get props => [estimateMethodList];
}

class EstimateMethodFailure extends EstimateMethodState {
  final String message;

  const EstimateMethodFailure({required this.message});

  @override
  List<Object> get props => [message];
}