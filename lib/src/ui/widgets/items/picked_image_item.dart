import 'dart:io';
//---------------
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class PickedImageItem extends StatelessWidget {
  final File image;

  final ValueChanged<File> onImageRemoval;

  const PickedImageItem({
    required this.image,
    required this.onImageRemoval,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = context.isRTL;
    return Padding(
      padding: EdgeInsets.only(
        right: isRTL ? 0 : SharedStyles.componentsPadding,
        left: isRTL ? SharedStyles.componentsPadding : 0.0,
      ),
      child: Stack(
        children: [
          Image.file(
            image,
            height: 100.0,
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            start: 3.0,
            top: 4.0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    "assets/icons/delete-cross.svg",
                    height: 12.0,
                    width: 12.0,
                    color: Palette.burntSienna,
                  ),
                ),
                onTap: () => onImageRemoval(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
