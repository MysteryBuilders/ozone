import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/time_line_model.dart';
import 'package:ozon/domain/usecases/time_line_use_case.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  final TimeLineUseCase timeLineUseCase;

  TimeLineBloc(this.timeLineUseCase) : super(TimeLineInitial())
  {
    on<TimeLineFetched>((event, emit) async {
      emit(TimeLineLoading());
      (await timeLineUseCase.execute(TimeLineUseCaseInput(event.authorization,event.orderId))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(TimeLineFailure(message: failure.message)) ;
        },
            (response) async {




          emit(TimeLineSuccess(timeLine: response));



        },
      );

    });
  }
}

