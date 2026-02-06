import 'constants.dart';

extension NonNullString on String? {
  String orEmpty(){
    if(this == null){
      return Constants.empty;

    }else{
      return this!;
    }
  }


}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
extension PhoneValidator on String {
  bool isValidPhone() {
    return    RegExp(r'^[0-9]{8}$').hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
        r'^(?=.{8,})(?=.*[0-9])(?=.*[!@#\$&*~?])[A-Z][A-Za-z0-9!@#\$&*~?]*$')
        .hasMatch(this);
  }
}
extension NonNullInteger on int? {
  int orZero(){
    if(this == null){
      return Constants.zero;

    }else{
      return this!;
    }
  }




}

extension NonNullDouble on double? {
  double orDoubleZero(){
    if(this == null){
      return Constants.zeroDouble;

    }else{
      return this!;
    }
  }




}
extension NonNullBoolean on bool? {
  bool orBooleanFalse(){
    if(this == null){
      return Constants.falseBoolean;

    }else{
      return this!;
    }
  }




}
