import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
import 'package:original_base/src/ui/widgets/chat/screens/chat_image_viewer.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ImageMessageWidget extends StatelessWidget {
  final String imageUrl;
  final String senderName;

  const ImageMessageWidget(this.imageUrl, this.senderName);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == "uploading") {
      return Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: Palette.solitude,
          borderRadius: BorderRadius.circular(
            SharedStyles.smallComponentsRadius,
          ),
        ),
        child: CircularLoadingIndicator(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        SharedStyles.smallComponentsRadius,
      ),
      child: GestureDetector(
        onTap: () {
          Sailor.to(ChatImageViewer(imageUrl, senderName));
        },
        child: Hero(
          tag: imageUrl,
          child: getCachedImage(
            imageUrl,
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
  }
}
