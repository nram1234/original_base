import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

void showSnackBarAlert(
  String messageId,
  BuildContext context, {
  int durationInSeconds = 3,
}) {
  SnackBar alertSnackBar = SnackBar(
    elevation: 0.0,
    duration: Duration(seconds: durationInSeconds),
    backgroundColor: Palette.burntSienna,
    content: Text(
      messageId.translate(context),
      textAlign: TextAlign.center,
      style: TextStyles.subtitle2.copyWith(color: Colors.white),
    ),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(alertSnackBar);
}
