import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();
}

class PickImage extends ImagePickerEvent {
  final bool fromCamera;


  const PickImage({this.fromCamera = false});

  @override
  List<Object> get props => [fromCamera];
}
