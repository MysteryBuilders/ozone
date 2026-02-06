
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StatesUseCase implements BaseUseCase<StatesUseCaseInput,List<StateModel>>{
  final Repository _repository;
  StatesUseCase(this._repository);

  @override
  Future<Either<Failure, List<StateModel>>> execute(StatesUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.states(input.countryCode);
  }


}
class StatesUseCaseInput {
  String countryCode;


  StatesUseCaseInput(this.countryCode);
}