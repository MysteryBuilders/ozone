class ImageSplashModel{
  String? imageUrl;
  String? type;
  String ? id;
  ImageSplashModel(this.imageUrl,this.type,this.id);
}
class SplashModel{
  String? gif;
  int? timeout;
  List<ImageSplashModel>? imageSplashList;
  SplashModel(this.gif,this.timeout,this.imageSplashList);
}