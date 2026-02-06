
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/contact_us_model.dart';
import 'package:ozon/domain/model/country_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ContactUsDetailsUseCase implements BaseUseCase<ContactUsDetailsUseCaseInput,ContactUsModel>{
  final Repository _repository;
  ContactUsDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ContactUsModel>> execute(ContactUsDetailsUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.contactusDetails(input.authorization);
  }


}
class ContactUsDetailsUseCaseInput {
  String authorization;


  ContactUsDetailsUseCaseInput(this.authorization);
}