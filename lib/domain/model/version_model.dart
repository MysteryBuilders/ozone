class VersionResultModel{
  int ios;
  int android;
  VersionResultModel(this.ios,this.android);
}
class VersionDataModel{
  VersionResultModel? versionResultModel;
  VersionDataModel(this.versionResultModel);
}
class VersionModel{
  VersionDataModel? versionDataModel;
  VersionModel(this.versionDataModel);
}