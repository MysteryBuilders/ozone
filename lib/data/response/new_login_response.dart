import 'package:json_annotation/json_annotation.dart';
part 'new_login_response.g.dart';
@JsonSerializable()
class NewLoginResponse {
  @JsonKey(name:"token" )
  String? token;
  NewLoginResponse(this.token);
  // from json

  factory NewLoginResponse.fromJson(Map<String,dynamic> json) =>_$NewLoginResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$NewLoginResponseToJson(this);

}