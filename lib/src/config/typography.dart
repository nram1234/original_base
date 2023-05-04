import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

/// This class contains shared text styles used on original apps.
/// Default text styles are based on Material design standards.
/// Default color for headlines, titles and subtitles is the primary color
/// while accent color is the default of captions and overlines and lastly
/// black is the default color for body texts.
class TextStyles {
  static final TextStyle h4 = TextStyle(
    fontSize: 34.0.sp,
    fontWeight: FontWeight.w400,
    color: Palette.burntSienna,
  );

  static final TextStyle h5 = TextStyle(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w400,
    color: Palette.burntSienna,
  );

  static final TextStyle h6 = TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w500,
    color: Palette.burntSienna,
  );

  static final TextStyle title = TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w700,
    color: Palette.burntSienna,
  );

  static final TextStyle subtitle1 = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: Palette.burntSienna,
  );

  static final TextStyle subtitle2 = TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: Palette.burntSienna,
  );

  static final TextStyle body1 = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle body2 = TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle caption = TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w400,
    color: Palette.shuttleGray,
  );

  static final TextStyle overline = TextStyle(
    fontSize: 10.0.sp,
    fontWeight: FontWeight.w400,
    color: Palette.shuttleGray,
  );
}

/// This class contains all font families used on original apps.
class FontFamilies {
  static const String dinNext = "DINNextLT";
  static const String almarai = "Almarai";
  static const String roboto = "Roboto";
}
