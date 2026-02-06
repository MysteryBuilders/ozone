import 'package:json_annotation/json_annotation.dart';
part 'splash_response.g.dart';
@JsonSerializable()
class ImageSplashResponse{
  @JsonKey(name:"image_url" )
  String? imageUrl;
  @JsonKey(name:"type" )
  String? type;
  @JsonKey(name:"id" )
  String? id;


  ImageSplashResponse(this.imageUrl,this.type,this.id);
  // from json

  factory ImageSplashResponse.fromJson(Map<String,dynamic> json) =>_$ImageSplashResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$ImageSplashResponseToJson(this);

}
@JsonSerializable()
class SplashResponse{
  @JsonKey(name:"gif" )
  String? gif;
  @JsonKey(name:"timeout" )
  int? timeout;
  @JsonKey(name:"images" )
  List<ImageSplashResponse> imageSplashList;
  SplashResponse(this.gif,this.timeout,this.imageSplashList);
  // from json
  factory SplashResponse.fromJson(Map<String,dynamic> json) =>_$SplashResponseFromJson(json);
// to json
  Map<String,dynamic> toJson() => _$SplashResponseToJson(this);
}