import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class NavigationButton extends StatelessWidget {
  final bool showTrailingArrow;

  /// id used to get title translation.
  final String titleID;

  final VoidCallback onTapped;

  NavigationButton({
    this.showTrailingArrow = true,
    required this.titleID,
    required this.onTapped,
  });

  late final String leadingIconAssetName;

  @override
  Widget build(BuildContext context) {
    leadingIconAssetName = titleID.replaceFirst("#", "") + ".svg";
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SharedStyles.mediumComponentsRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 30.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/$leadingIconAssetName",
                    width: 20.0,
                    color: Palette.shuttleGray,
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    titleID.translate(context),
                    style: TextStyles.body2.copyWith(
                      color: Palette.shuttleGray,
                    ),
                  ),
                ],
              ),
              showTrailingArrow
                  ? RotatedBox(
                      quarterTurns: context.isRTL ? 0 : 2,
                      child: SvgPicture.asset(
                        "assets/icons/forward_arrow.svg",
                        height: 18.0,
                        width: 18.0,
                        color: Palette.linkWater,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        onTap: onTapped,
      ),
    );
  }
}
