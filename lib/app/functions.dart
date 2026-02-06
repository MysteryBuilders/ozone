import 'package:ozon/app/constants.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}


String handleEndpointImage(String image) {
  if (image.isNotEmpty) {
    return image.toString().contains('media/')
        ? '${Constants.domain}/$image'
        : '${Constants.domain}/pub/media/catalog/category/$image';
  }
  return Constants.kDefaultImage;
}