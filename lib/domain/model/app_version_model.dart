class AppVersionDataModel{
  final String versionId;
  final int ios;
  final int android;
  AppVersionDataModel({required this.versionId,required this.ios,required this.android});
}
class AppVersionModel{
  List<AppVersionDataModel>? versionsList;
  AppVersionModel({required this.versionsList});
}