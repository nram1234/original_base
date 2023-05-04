import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class MapView extends StatelessWidget {
  final bool showDivider;

  final String mapKey;
  final String mapValue;

  final TextDirection? textDirection;

  const MapView({
    this.showDivider = true,
    required this.mapKey,
    required this.mapValue,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mapKey,
          style: TextStyles.caption.copyWith(
            fontSize: 13.0.sp,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          mapValue,
          textDirection: textDirection,
          style: TextStyles.caption.copyWith(
            fontSize: 13.0.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: SharedStyles.componentsPadding),
        if (showDivider) ...[
          Divider(
            color: Palette.solitude,
            thickness: 2.0,
            height: 1.0,
          ),
          SizedBox(height: 11.0),
        ],
      ],
    );
  }
}
