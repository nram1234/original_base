import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//----------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/models/original_app_type.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/constants.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

/// an alert that forces the user to upgrade his app.
Future<void> showAppUpgradeAlert(
  OriginalAppType appType,
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SharedStyles.smallComponentsRadius,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
        titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        title: Text(
          "#app_upgrade_required".translate(context),
          textAlign: TextAlign.start,
          style: TextStyles.title.copyWith(
            fontWeight: FontWeight.w400,
            color: Palette.shuttleGray,
          ),
        ),
        content: Text(
          "#upgrade_your_app".translate(context),
          textAlign: TextAlign.start,
          style: TextStyles.subtitle2.copyWith(
            color: Palette.shuttleGray,
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Palette.overlayColor,
              ),
            ),
            child: Text(
              "#upgrade".translate(context),
              style: TextStyles.body2.copyWith(
                fontWeight: FontWeight.w500,
                color: Palette.burntSienna,
              ),
            ),
            onPressed: () {
              String appLink = Constants.getStoreLinkFromAppType(appType);
              launch(appLink);
            },
          ),
        ],
      );
    },
  );
}
