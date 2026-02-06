import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/range_bloc/price_range_event.dart';
import 'package:ozon/presentation/product_details/bloc/range_bloc/price_range_state.dart';

class PriceRangeBloc extends Bloc<PriceRangeEvent, PriceRangeState> {
  PriceRangeBloc() : super(PriceRangeState(const RangeValues(0, 0))) {
    on<LoadInitialRange>((event, emit) {
      emit(PriceRangeState(event.initialRange));
    });

    on<UpdatePriceRange>((event, emit) {
      emit(PriceRangeState(event.newRange));
    });
  }
}
