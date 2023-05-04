import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/buttons/action_button.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

enum FailureType { networkError, emptyResult }

class FailureWidget extends StatelessWidget {
  final double bottomPadding;

  final String title;

  final FailureType failureType;

  final VoidCallback? onResolve;

  const FailureWidget({
    this.bottomPadding = 0.0,
    required this.title,
    this.failureType = FailureType.networkError,
    this.onResolve,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              failureType == FailureType.networkError
                  ? "assets/images/network_error.svg"
                  : "assets/images/empty_result.svg",
              width: 175.0,
              height: 150.0,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SharedStyles.componentsPadding,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.subtitle2.copyWith(
                  color: Palette.shuttleGray,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            if (onResolve != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    buttonWidth: 159.0,
                    text: "#re_connect".translate(context),
                    onAction: this.onResolve!,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
