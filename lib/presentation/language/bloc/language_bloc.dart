

import 'dart:ui';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../resources/langauge_manager.dart';
import 'language_event.dart';
import 'language_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState(ARABIC_LOCAL)) {
    on<ChangeLocale>((event, emit) {
      emit(LocalizationState(event.locale));
      // Update easy_localization's locale
      event.context.setLocale(event.locale);
    });
    on<DefaultLocale>((event, emit) {
      emit(LocalizationState(event.locale));
      // Update easy_localization's locale
      event.context.setLocale(event.locale);
    });
  }
}
