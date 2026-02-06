
import 'package:dartz/dartz.dart';
import 'package:ozon/domain/model/add_to_cart_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/domain/model/time_line_model.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class TimeLineUseCase implements BaseUseCase<TimeLineUseCaseInput,TimeLine>{
  final Repository _repository;
  TimeLineUseCase(this._repository);

  @override
  Future<Either<Failure, TimeLine>> execute(TimeLineUseCaseInput input) async{
    // TODO: implement execute
    return await _repository.timeLine(input.authorization,input.orderId);
  }


}
class TimeLineUseCaseInput {
  String authorization;
  String orderId;


  TimeLineUseCaseInput(this.authorization,this.orderId);
}