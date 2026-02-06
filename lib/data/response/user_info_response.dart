import 'package:json_annotation/json_annotation.dart';
part 'user_info_response.g.dart';
@JsonSerializable()
class UserInfoResponse {
  @JsonKey(name:"id" )
  int? id;
  @JsonKey(name:"email" )
  String? email;
  @JsonKey(name:"firstname" )
  String? firstname;
  @JsonKey(name:"lastname" )
  String? lastname;
  @JsonKey(name:"store_id" )
  int? storeId;
  @JsonKey(name:"website_id" )
  int? websiteId;
  UserInfoResponse(this.id,this.email,this.firstname,this.lastname,
      this.storeId,this.websiteId);
  // from json

  factory UserInfoResponse.fromJson(Map<String,dynamic> json) =>_$UserInfoResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$UserInfoResponseToJson(this);

}