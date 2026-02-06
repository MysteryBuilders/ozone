
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/generate_invoice_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GenerateInvoiceUseCase implements BaseUseCase<GeneratInvoiceUseCaseInput,List<dynamic>>{
  final Repository _repository;
  GenerateInvoiceUseCase(this._repository);

  @override
  Future<Either<Failure, List<dynamic>>> execute(GeneratInvoiceUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.generateInvoice(input.authoriztion,input.invoiceValue,input.customerName,input.countryCode);
  }


}
class GeneratInvoiceUseCaseInput {

  String authoriztion; String invoiceValue; String customerName; String countryCode;



  GeneratInvoiceUseCaseInput(this.authoriztion,this.invoiceValue,this.customerName,this.countryCode);
}