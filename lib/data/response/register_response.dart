import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';
@JsonSerializable()
class RegisterResponse {

  @JsonKey(name:"id" )
  int? id;
  @JsonKey(name:"group_id" )
  int? group_id;
  @JsonKey(name:"created_at" )
  String? created_at;
  @JsonKey(name:"updated_at" )
  String? updated_at;
  @JsonKey(name:"created_in" )
  String? created_in;
  @JsonKey(name:"email" )
  String? email;
  @JsonKey(name:"firstname" )
  String? firstname;
  @JsonKey(name:"lastname" )
  String? lastname;
  @JsonKey(name:"store_id" )
  int? store_id;
  @JsonKey(name:"website_id" )
  int? website_id;

  RegisterResponse(this.id,this.group_id,this.created_at,this.updated_at,
      this.created_in,this.email,this.firstname,this.lastname,this.store_id,this.website_id);
  // from json

  factory RegisterResponse.fromJson(Map<String,dynamic> json) =>_$RegisterResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$RegisterResponseToJson(this);

}