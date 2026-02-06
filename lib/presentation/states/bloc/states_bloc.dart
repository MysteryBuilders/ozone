import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/domain/usecases/states_use_case.dart';

part 'states_event.dart';
part 'states_state.dart';

class StatesBloc extends Bloc<StatesEvent, StatesState> {
  final StatesUseCase statesUseCase;
  List<StateModel> allStates = [];
  StateModel? selectState;

  StatesBloc(this.statesUseCase) : super(StatesInitial()) {
    on<InitStates>((event,emit)async{
      emit(StatesInitial());
    });
    on<StatesFetched>((event, emit) async {
      emit(StatesLoading());
      (await statesUseCase.execute(StatesUseCaseInput(event.countryCode))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(StatesFailure(message: failure.message)) ;
        },
            (response) async {
              allStates = response;



          emit(StatesSuccess(statesList: response,selectState: selectState??response[0]));



        },
      );

    });
    on<SelectStates>(_onSelectCountry);
    on<SearchStates>(_onSearchCountries);
  }
  void _onSelectCountry(
      SelectStates event,
      Emitter<StatesState> emit,
      ) {
    selectState = event.stateModel;

    // if (state is StatesSuccess) {

      emit(StatesSuccess(
        statesList: allStates,
        selectState: event.stateModel,
      ));
    // }

  }
  void _onSearchCountries(
      SearchStates event,
      Emitter<StatesState> emit,
      ) {
    final query = event.query.toLowerCase();
    if(query.isEmpty){
      emit(StatesSuccess(statesList: allStates,selectState: selectState?? allStates.first));
    }else {
      final filteredCountries = allStates.where((country) {
        final englishName = country.name;

        return englishName!.contains(query) ;
      }).toList();

      emit(StatesSuccess(statesList: filteredCountries,selectState: selectState?? allStates.first));
    }
  }
}
