import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

/// An interception alert that asks the user to make a certain action.
/// This method returns true if user canceled the action
/// or false if action is accepted.
Future<bool> showInterceptionAlert({
  /// determines if user can dismiss this alert.
  bool dismissible = true,

  /// id used to translate interception title.
  required String titleId,

  /// id used to translate interception message.
  required String messageId,

  /// id used to translate required action.
  required String actionId,
  required BuildContext context,
}) async {
  bool? cancelAction = await showDialog(
    barrierDismissible: dismissible,
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
          titleId.translate(context),
          textAlign: TextAlign.start,
          style: TextStyles.title.copyWith(
            fontWeight: FontWeight.w400,
            color: Palette.shuttleGray,
          ),
        ),
        content: Text(
          messageId.translate(context),
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
              actionId.translate(context),
              style: TextStyles.body2.copyWith(
                fontWeight: FontWeight.w500,
                color: Palette.burntSienna,
              ),
            ),
            onPressed: () => Sailor.back(false),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Palette.overlayColor,
              ),
            ),
            child: Text(
              "#cancel".translate(context),
              style: TextStyles.body2.copyWith(
                fontWeight: FontWeight.w500,
                color: Palette.burntSienna,
              ),
            ),
            onPressed: () => Sailor.back(true),
          ),
        ],
      );
    },
  );

  // if user dismissed the alert return true.
  return cancelAction ?? true;
}
