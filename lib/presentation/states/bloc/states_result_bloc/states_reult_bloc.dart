import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/state_model.dart';

part 'states_reult_event.dart';
part 'states_reult_state.dart';

class StatesReultBloc extends Bloc<StatesReultEvent, StatesReultState> {
  StatesReultBloc() : super( StatesReultInitial()) {
    on<SelectStatesReultFetch>((event, emit) {
      emit(StatesResultStateSuccess(stateModel:event.stateModel));
    });
    on<ResetStatesReultFetch>((event, emit) {
      emit(StatesReultInitial());
    });
  }
}
