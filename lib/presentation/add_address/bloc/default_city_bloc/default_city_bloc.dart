import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ozon/app/app_prefrences.dart';

import '../../../../domain/model/country_model.dart';
import '../../../../domain/model/state_model.dart';

part 'default_city_event.dart';
part 'default_city_state.dart';

class DefaultCityBloc extends Bloc<DefaultCityEvent, DefaultCityState> {
  AppPreferences _appPreferences;
  DefaultCityBloc(this._appPreferences) : super(DefaultCityInitial()) {
    on<DefaultCityFetched>((event, emit) async {
      emit(DefaultCityLoading());
      StateModel? stateModel = await _appPreferences.getState();
      CountryModel? countryModel = await _appPreferences.getCountry();
      emit(DefaultCitySuccess(mCountryModel: countryModel!, mStateModel: stateModel!));


    });
  }

}
