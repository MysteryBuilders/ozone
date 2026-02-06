part of 'estimate_method_bloc.dart';

sealed class EstimateMethodEvent extends Equatable {
  const EstimateMethodEvent();
}

class EstimateMethodFetched extends EstimateMethodEvent {
  final Map<String,dynamic> map;
  final String authorization;


  const EstimateMethodFetched(this.map,this.authorization);

  @override
  List<Object> get props => [map,Random().nextDouble(),authorization];
}