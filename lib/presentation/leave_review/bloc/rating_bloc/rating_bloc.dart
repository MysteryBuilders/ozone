import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozon/presentation/leave_review/bloc/rating_bloc/rating_event.dart';
import 'package:ozon/presentation/leave_review/bloc/rating_bloc/rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  RatingBloc() : super(RatingState(0.0)) {
    on<RatingChanged>((event, emit) {
      emit(RatingState(event.rating));
    });
  }
}
