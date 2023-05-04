import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ActionButton extends StatelessWidget {
  final bool showNavigationArrow;
  final bool showBorderSide;

  /// determines if the button width should match [text] width;
  final bool wrapParent;

  final double elevation;
  final double buttonHeight;
  final double buttonWidth;

  final String? text;

  final Color textColor;
  final Color buttonColor;
  final Color navigationArrowColor;

  final BorderRadius? borderRadius;

  final VoidCallback onAction;

  final Widget? icon;
  final Widget? customWidget;

  const ActionButton({
    this.showNavigationArrow = false,
    this.showBorderSide = false,
    this.wrapParent = false,
    this.elevation = 2.0,
    this.buttonHeight = 48.0,
    this.buttonWidth = 151.0,
    this.text,
    this.textColor = Colors.white,
    this.buttonColor = Palette.burntSienna,
    this.navigationArrowColor = Palette.burntSienna,
    this.borderRadius,
    required this.onAction,
    this.customWidget,
    this.icon,
  }) : assert(icon != null || text != null || customWidget != null);

  Widget get resolveChild {
    if (customWidget != null) {
      return customWidget!;
    } else if (icon != null) {
      return icon!;
    } else {
      return Text(
        text!,
        style: TextStyles.subtitle2.copyWith(
          height: 1.0,
          color: textColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: wrapParent ? null : buttonWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.circular(SharedStyles.smallComponentsRadius),
              side: showBorderSide
                  ? BorderSide(
                      color: Palette.burntSienna,
                      width: 2.0,
                    )
                  : BorderSide.none,
            ),
          ),
          elevation: MaterialStateProperty.all(elevation),
          overlayColor: MaterialStateProperty.all(Palette.overlayColor),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showNavigationArrow)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SvgPicture.asset(
                    "assets/icons/right_arrow.svg",
                    height: 16.0,
                    width: 18.5,
                    color: navigationArrowColor,
                  ),
                ),
              resolveChild,
            ],
          ),
        ),
        onPressed: onAction,
      ),
    );
  }
}
