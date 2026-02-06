import 'package:json_annotation/json_annotation.dart';
part 'state_response.g.dart';
@JsonSerializable()
class StateResponse{

  @JsonKey(name:"state_id" )
  String? stateId;
  @JsonKey(name:"name" )
  String? name;


  StateResponse(this.stateId,this.name);
  // from json

  factory StateResponse.fromJson(Map<String,dynamic> json) =>_$StateResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$StateResponseToJson(this);

}