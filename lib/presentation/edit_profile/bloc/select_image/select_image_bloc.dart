import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ozon/presentation/edit_profile/bloc/select_image/select_image_event.dart';
import 'package:ozon/presentation/edit_profile/bloc/select_image/select_image_state.dart';


class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImage>(_onPickImage);
  }

  Future<void> _onPickImage(PickImage event, Emitter<ImagePickerState> emit) async {
    emit(ImagePickerLoading(
    ));
    try {
      final pickedFile = await _picker.pickImage(
        source: event.fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedFile != null) {
        emit(ImagePickerSuccess(File(pickedFile.path)));
      } else {
        emit(ImagePickerFailure("No image selected"));
      }
    } catch (e) {
      emit(ImagePickerFailure(e.toString()));
    }
  }
}
