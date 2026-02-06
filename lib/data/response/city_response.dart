import 'package:json_annotation/json_annotation.dart';
part 'city_response.g.dart';
@JsonSerializable()
class CityResponse{

  @JsonKey(name:"entity_id" )
  String? entity_id;
  @JsonKey(name:"states_name" )
  String? states_name;
  @JsonKey(name:"cities_name" )
  String? cities_name;


  CityResponse(this.entity_id,this.states_name,this.cities_name);
  // from json

  factory CityResponse.fromJson(Map<String,dynamic> json) =>_$CityResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$CityResponseToJson(this);

}