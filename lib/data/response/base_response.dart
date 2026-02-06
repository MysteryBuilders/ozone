import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';
@JsonSerializable()
class BaseResponse{

  @JsonKey(name:"ok" )
  bool? isOk;
  @JsonKey(name:"error" )
  String? error;
  @JsonKey(name:"status" )
  String? status;


}