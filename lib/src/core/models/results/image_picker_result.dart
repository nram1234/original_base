import 'dart:io';
//---------------

abstract class ImagePickerResult {}

class ImagePickedSuccessfully extends ImagePickerResult {
  final File image;

  ImagePickedSuccessfully(this.image);
}

class ImagePickerCanceledByUser extends ImagePickerResult {}

class ErrorWhilePickingImage extends ImagePickerResult {}
