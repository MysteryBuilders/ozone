import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/rating_model.dart';
import 'package:ozon/domain/usecases/rating_usecase.dart';

part 'leave_review_event.dart';
part 'leave_review_state.dart';

class LeaveReviewBloc extends Bloc<LeaveReviewEvent, LeaveReviewState> {
  final RatingUsecase ratingUsecase;

  LeaveReviewBloc(this.ratingUsecase) : super(LeaveReviewInitial()) {
    on<LeaveReviewButtonPressed>((event, emit) async {
      emit(LeaveReviewLoading());
      (await ratingUsecase.execute(RatingUsecaseInput(event.authorization,event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(LeaveReviewFailure(message: failure.message)) ;
        },
            (response) async {




          emit(LeaveReviewSuccess(ratingModel: response));



        },
      );

    });
  }

}
