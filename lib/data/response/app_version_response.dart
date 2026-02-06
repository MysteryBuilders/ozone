import 'package:json_annotation/json_annotation.dart';
part 'app_version_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AppVersionDataResponse {
  @JsonKey(name: 'version_id')
  final String versionId;

  @JsonKey(name: 'ios')
  final int ios;



  @JsonKey(name: 'andriod')
  final int andriod;
  AppVersionDataResponse({
  required this.versionId,
  required this.ios,

  required this.andriod,});
  factory AppVersionDataResponse.fromJson(Map<String, dynamic> json) => _$AppVersionDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionDataResponseToJson(this);

}
@JsonSerializable(explicitToJson: true)
class AppVersionResponse{
  @JsonKey(name: 'items')
  final List<AppVersionDataResponse> versions;
  AppVersionResponse({required this.versions});
  factory AppVersionResponse.fromJson(Map<String, dynamic> json) => _$AppVersionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AppVersionResponseToJson(this);

}