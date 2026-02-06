part of 'brands_bloc.dart';

sealed class BrandsEvent extends Equatable {
  const BrandsEvent();
}

class BrandsFetched extends BrandsEvent {
  final String authorization;


  const BrandsFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}