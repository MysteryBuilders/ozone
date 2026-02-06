import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/usecases/contact_us_details_use_case.dart';

part 'contact_us_details_event.dart';
part 'contact_us_details_state.dart';

class ContactUsDetailsBloc extends Bloc<ContactUsDetailsEvent, ContactUsDetailsState> {
  final ContactUsDetailsUseCase contactUsDetailsUseCase;


  ContactUsDetailsBloc(this.contactUsDetailsUseCase) : super(ContactUsDetailsInitial()) {
    on<ContactUsDetailsFetched>((event, emit) async {
      emit(ContactUsDetailsLoading());
      (await contactUsDetailsUseCase.execute(ContactUsDetailsUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(ContactUsDetailsFailure(message: failure.message)) ;
        },
            (response) async {




          emit(ContactUsDetailsSuccess(contactUsModel: response));



        },
      );

    });

  }

}
