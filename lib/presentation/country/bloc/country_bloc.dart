import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/country_model.dart';

import '../../../domain/usecases/countries_use_case.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountriesUseCase countriesUseCase;
  List<CountryModel> allCountries = [];
  CountryModel? selectedCountry;

  CountryBloc(this.countriesUseCase) : super(CountryInitial()) {
    on<CountriesFetched>((event, emit) async {
      emit(CountryLoading());
      (await countriesUseCase.execute(CountriesUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CountryFailure(message: failure.message)) ;
        },
            (response) async {
              allCountries = response;



          emit(CountrySuccess(categoryModel: response,countryModel:selectedCountry??allCountries[0] ));



        },
      );

    });
    on<SelectCountry>(_onSelectCountry);
    on<SearchCountries>(_onSearchCountries);
  }
  void _onSelectCountry(
      SelectCountry event,
      Emitter<CountryState> emit,
      ) {

    selectedCountry = event.country;

    // if (state is CountrySuccess) {
      print(event.country.fullNameEnglish);
      emit(CountrySuccess(
        categoryModel: allCountries,
        countryModel: event.country,
      ));
  // }
  }
  void _onSearchCountries(
      SearchCountries event,
      Emitter<CountryState> emit,
      ) {
    final query = event.query.toLowerCase();
    if(query.isEmpty){
      emit(CountrySuccess(categoryModel: allCountries,countryModel: selectedCountry?? allCountries.first));
    }else {
      final filteredCountries = allCountries.where((country) {
        final englishName = country.fullNameEnglish!.toLowerCase();
        final localizedName = country.fullNameLocale!.toLowerCase();
        return englishName.contains(query) || localizedName.contains(query);
      }).toList();

      emit(CountrySuccess(categoryModel: filteredCountries,countryModel: selectedCountry?? allCountries.first));
    }
  }

}
