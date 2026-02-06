
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/estimate_shipping_method.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ContactUsUseCase implements BaseUseCase<ContactUsUseCaseInput,String>{
  final Repository _repository;
  ContactUsUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(ContactUsUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.contactUs(input.map);
  }


}
class ContactUsUseCaseInput {
  Map<String,dynamic> map;




  ContactUsUseCaseInput(this.map);
}