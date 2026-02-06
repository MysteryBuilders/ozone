
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CountriesUseCase implements BaseUseCase<CountriesUseCaseInput,List<CountryModel>>{
  final Repository _repository;
  CountriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<CountryModel>>> execute(CountriesUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.countries(input.authorization);
  }


}
class CountriesUseCaseInput {
  String authorization;


  CountriesUseCaseInput(this.authorization);
}