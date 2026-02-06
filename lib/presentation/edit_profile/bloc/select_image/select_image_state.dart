import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();
}

class ImagePickerInitial extends ImagePickerState {

  const ImagePickerInitial();
  @override
  List<Object> get props => [];
}

class ImagePickerLoading extends ImagePickerState {

  const ImagePickerLoading();
  @override
  List<Object> get props => [];
}

class ImagePickerSuccess extends ImagePickerState {
  final File image;


  const ImagePickerSuccess(this.image);

  @override
  List<Object> get props => [image];
}

class ImagePickerFailure extends ImagePickerState {
  final String error;


  const ImagePickerFailure(this.error);

  @override
  List<Object> get props => [error];
}
