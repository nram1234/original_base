import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ScaffoldCurvedBody extends StatelessWidget {
  final double horizontalPadding;

  final Color? bodyColor;
  final Color? curveColor;

  final Widget child;

  const ScaffoldCurvedBody({
    this.horizontalPadding = 24.0,
    this.bodyColor = Colors.white,
    this.curveColor = Palette.burntSienna,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: curveColor,
      child: Container(
        decoration: BoxDecoration(
          color: bodyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SharedStyles.largeComponentsRadius),
            topRight: Radius.circular(SharedStyles.largeComponentsRadius),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: child,
      ),
    );
  }
}
