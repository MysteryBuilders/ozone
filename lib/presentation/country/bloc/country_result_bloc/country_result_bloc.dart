import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/model/country_model.dart';
import 'country_result_event.dart';
import 'country_result_state.dart';



class CountryResultBloc extends Bloc<CountryResultEvent, CountryResultState> {
  CountryResultBloc() : super( CountryInitial()) {
    on<SelectCountryResultFetch>((event, emit) {
      emit(CountryResultStateSuccess(countryModel:event.country));
    });
    on<ResetCountryReultFetch>((event, emit) {
      emit(CountryInitial());
    });
  }
}
