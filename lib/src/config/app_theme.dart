import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/layout/screen_header.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

final appTheme = ThemeData(
  primaryColor: Palette.burntSienna,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Palette.primarySwatch,
    accentColor: Palette.shuttleGray,
  ),
  // set DINNext as the default font family.
  fontFamily: FontFamilies.dinNext,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
);

class SharedStyles {
  /// amount of shared padding used in most of app components.
  static const double componentsPadding = 16.0;

  /// amount of shared border radius used in large-sized components.
  static const double largeComponentsRadius = 25.0;

  /// amount of shared border radius used in medium-sized components.
  static const double mediumComponentsRadius = 15.0;

  /// amount of shared border radius used in small-sized components.
  static const double smallComponentsRadius = 7.0;

  /// separator width between products columns.
  static const double productCrossAxisSpacing = 12.0;

  /// height of product item card.
  static const double productItemHeight = 212.0;

  /// [ScreenHeader] appbar height.
  static const double screenHeaderHeight = 60.0;

  /// average animation duration recommended for user experience.
  static const Duration animationDuration = Duration(milliseconds: 250);

  /// amount of empty white space left in the bottom of
  /// scrollable screens for better user experience.
  static final SizedBox screenBottomSpace = SizedBox(height: 30.0);

  /// amount of shared shadow used in app components.
  static final BoxShadow sharedShadow = BoxShadow(
    color: Colors.black.withOpacity(0.16),
    spreadRadius: 12.0,
    blurRadius: 20.0,
    offset: Offset(0.0, 10.0),
  );

  /// resolves the width of product card.
  static double getProductItemWidth(
    BuildContext context, {
    double viewportFraction = 1.0,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double innerEmptySpace = productCrossAxisSpacing + (componentsPadding * 2);
    return (screenWidth - innerEmptySpace) / (2.0 * viewportFraction);
  }
}

/// an extension method that customizes box shadows.
extension customShadow on BoxShadow {
  BoxShadow copyWith({
    double? customSpreadRadius,
    double? customBlurRadius,
    Color? customColor,
    Offset? customOffset,
  }) {
    return BoxShadow(
      spreadRadius: customSpreadRadius ?? this.spreadRadius,
      blurRadius: customBlurRadius ?? this.blurRadius,
      offset: customOffset ?? this.offset,
      color: customColor ?? this.color,
    );
  }
}
