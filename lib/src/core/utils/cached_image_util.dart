import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//--------------------------------------------------------------
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
//------------------------------------------------------------------------------------

Widget getCachedImage(
  String imageUrl, {
  double? height,
  double? width,
  BoxFit fit = BoxFit.contain,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: height,
    width: width,
    fit: fit,
    alignment: Alignment.center,
    filterQuality: FilterQuality.high,
    fadeInDuration: const Duration(seconds: 1),
    progressIndicatorBuilder: (_, __, downloadProgress) {
      return CircularLoadingIndicator(
        loadingValue: downloadProgress.progress,
      );
    },
    errorWidget: (_, __, ___) {
      return Image.asset(
        "assets/images/place_holder.jpg",
        width: width,
        height: height,
      );
    },
  );
}
