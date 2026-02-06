import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/update_profile_use_case.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  EditProfileBloc(this.updateProfileUseCase) : super(EditProfileInitial()) {
    on<EditProfileButtonPressed>((event, emit) async {
      emit(EditProfileLoading());
      (await updateProfileUseCase.execute(UpdateProfileUseCaseInput(event.email,event.password,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(EditProfileFailure(message: failure.message)) ;
        },
            (response) async {




          emit(EditProfileSuccess(isSuccess: response));



        },
      );

    });
  }
}
