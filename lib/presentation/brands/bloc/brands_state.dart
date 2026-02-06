part of 'brands_bloc.dart';

sealed class BrandsState extends Equatable {
  const BrandsState();
}

final class BrandsInitial extends BrandsState {
  @override
  List<Object> get props => [];
}

class BrandsStateLoading extends BrandsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class BrandsStateSuccess extends BrandsState {
  final List<BrandsDataModel> brandsList;

  const BrandsStateSuccess({required this.brandsList});

  @override
  List<Object> get props => [brandsList];
}

class BrandsStateFailure extends BrandsState {
  final String message;

  const BrandsStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
