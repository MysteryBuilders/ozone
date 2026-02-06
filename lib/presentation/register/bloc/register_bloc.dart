import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ozon/domain/model/register_model.dart';
import 'package:ozon/domain/usecases/register_usecase.dart';
import 'package:ozon/presentation/register/bloc/register_event.dart';
import 'package:ozon/presentation/register/bloc/register_state.dart';



class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      (await registerUseCase.execute(RegisterUseCaseInput(event.email,
          event.firstName,event.lastName,event.password,event.authorization,event.phoneNumber,event.countryCode,event.stateId,event.storeCode))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(RegisterFailure(message: failure.message)) ;
        },
            (response) async {




          emit(RegisterSuccess(registerModel: response));



        },
      );

    });
  }
}
