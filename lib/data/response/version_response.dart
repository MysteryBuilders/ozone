import 'base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'version_response.g.dart';

@JsonSerializable()
class VersionResultResponse {

  @JsonKey(name:"ios" )
  int? ios;
  @JsonKey(name:"android" )
  int? android;


  VersionResultResponse(this.ios,this.android);
  // from json

  factory VersionResultResponse.fromJson(Map<String,dynamic> json) =>_$VersionResultResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$VersionResultResponseToJson(this);

}

@JsonSerializable()
class VersionDataResponse {

  @JsonKey(name:"versions" )
  VersionResultResponse? versionResultResponse;



  VersionDataResponse(this.versionResultResponse);
  // from json

  factory VersionDataResponse.fromJson(Map<String,dynamic> json) =>_$VersionDataResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$VersionDataResponseToJson(this);

}

@JsonSerializable()
class VersionResponse extends BaseResponse {

  @JsonKey(name:"data" )
  VersionDataResponse? versionDataResponse;



  VersionResponse(this.versionDataResponse);
  // from json

  factory VersionResponse.fromJson(Map<String,dynamic> json) =>_$VersionResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$VersionResponseToJson(this);

}