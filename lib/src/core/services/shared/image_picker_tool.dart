import 'dart:io';
//---------------
import 'package:image_picker/image_picker.dart';
//----------------------------------------------
import 'package:original_base/src/core/models/results/image_picker_result.dart';
//------------------------------------------------------------------------------

class ImagePickerTool {
  final _imagePicker = ImagePicker();

  Future<ImagePickerResult> pickImage(ImageSource imageSource) async {
    try {
      XFile? pickedImage = await _imagePicker.pickImage(
        source: imageSource,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 540,
        maxHeight: 520,
      );
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        return ImagePickedSuccessfully(image);
      } else {
        return ImagePickerCanceledByUser();
      }
    } catch (_) {
      return ErrorWhilePickingImage();
    }
  }
}
