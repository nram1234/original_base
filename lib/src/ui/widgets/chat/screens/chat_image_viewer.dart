import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/layout/screen_header.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
//-------------------------------------------------------------------

class ChatImageViewer extends StatelessWidget {
  final String imageUrl;
  final String senderName;

  ChatImageViewer(this.imageUrl, this.senderName);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ScreenHeader(
          title: "#sent_by".translate(context) + " $senderName",
        ),
        body: Center(
          child: Hero(
            tag: imageUrl,
            child: InteractiveViewer(
              child: getCachedImage(
                imageUrl,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
