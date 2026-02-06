import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_select_event.dart';
part 'brand_select_state.dart';

class BrandSelectBloc extends Bloc<BrandSelectEvent, BrandSelectState> {

  BrandSelectBloc() : super(BrandSelectInitial()) {
    on<BrandsSelectFetched>((event, emit) async {
     emit(BrandSelectSuccess( index: event.index));

    });

  }
}
