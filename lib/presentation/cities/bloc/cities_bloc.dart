import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/usecases/city_use_case.dart';

part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final CityUseCase cityUseCase;
  List<CityModel> allCities = [];
  CityModel? selectedCityModel;

  CitiesBloc(this.cityUseCase) : super(CitiesInitial()) {
    on<InitCities>((event,emit)async{
      emit(CitiesInitial());
    });
    on<CitiesFetched>((event, emit) async {
      emit(CitiesLoading());
      (await cityUseCase.execute(CityUseCaseInput(event.stateName))).fold(
            (failure) {
          print("failture ---> $failure");
          emit(CitiesFailure(message: failure.message));
        },
            (response) async {
          allCities = response;


          emit(CitiesSuccess(citiesModel: response,selectedCity:selectedCityModel??response[0] ));
        },
      );
    });
    on<SelectCity>(_onSelectCountry);
    on<SearchCities>(_onSearchCountries);
  }

  void _onSelectCountry(SelectCity event,
      Emitter<CitiesState> emit,) {
    selectedCityModel = event.cityModel;

    // if (state is CitiesSuccess) {

      emit(CitiesSuccess(
        citiesModel: allCities,
        selectedCity: selectedCityModel!,
      ));
    // }

  }

  void _onSearchCountries(SearchCities event,
      Emitter<CitiesState> emit,) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(CitiesSuccess(citiesModel: allCities,selectedCity: selectedCityModel?? allCities.first));
    } else {
      final filteredCountries = allCities.where((country) {
        final englishName = country.cityName;

        return englishName!.contains(query);
      }).toList();

      emit(CitiesSuccess(citiesModel: filteredCountries,selectedCity: selectedCityModel?? allCities.first));
    }
  }
}