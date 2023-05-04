import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
//----------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/models/results/image_picker_result.dart';
import 'package:original_base/src/core/services/shared/image_picker_tool.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

Future<ImagePickerResult> showImageSourcePopup(BuildContext context) async {
  ImagePickerResult? pickerResult = await showCupertinoModalPopup(
    context: context,
    barrierColor: Palette.overlayColor,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: CupertinoActionSheet(
          title: Text(
            "#select_image_source".translate(context),
            style: TextStyles.subtitle1,
          ),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                "#camera".translate(context),
                style: TextStyles.subtitle2.copyWith(color: Colors.black),
              ),
              onPressed: () {
                ImagePickerTool().pickImage(ImageSource.camera).then((result) {
                  Sailor.back(result);
                });
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                "#gallery".translate(context),
                style: TextStyles.subtitle2.copyWith(color: Colors.black),
              ),
              onPressed: () {
                ImagePickerTool().pickImage(ImageSource.gallery).then((result) {
                  Sailor.back(result);
                });
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: Text(
              "#cancel".translate(context),
              style: TextStyles.subtitle1,
            ),
            onPressed: () {
              Sailor.back(ImagePickerCanceledByUser());
            },
          ),
        ),
      );
    },
  );

  return pickerResult ?? ImagePickerCanceledByUser();
}
