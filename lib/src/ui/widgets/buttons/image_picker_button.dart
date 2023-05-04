import 'dart:io';
//---------------
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ImagePickerButton extends StatelessWidget {
  final String currentUserImageUrl;

  final File? pickedImage;

  final VoidCallback onPicked;

  const ImagePickerButton({
    required this.currentUserImageUrl,
    required this.pickedImage,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: pickedImage != null || currentUserImageUrl.isNotEmpty
            ? GestureDetector(
                onTap: onPicked,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: pickedImage == null
                      ? getCachedImage(
                          currentUserImageUrl,
                          width: 108.0,
                          height: 104.0,
                        )
                      : Image.file(
                          pickedImage!,
                          height: 104.0,
                        ),
                ),
              )
            : MaterialButton(
                height: 104.0,
                minWidth: 108.0,
                elevation: 0.0,
                color: Palette.solitude,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SvgPicture.asset(
                  "assets/icons/camera.svg",
                  width: 31.67,
                  height: 27.4,
                ),
                onPressed: onPicked,
              ),
      ),
    );
  }
}
