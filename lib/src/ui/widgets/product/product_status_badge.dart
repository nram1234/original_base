import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ProductStatusBadge extends StatelessWidget {
  final String status;

  const ProductStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SharedStyles.smallComponentsRadius,
        ),
        border: Border.all(
          color: Palette.burntSienna,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyles.overline.copyWith(
            height: 1.0,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamilies.almarai,
            color: Palette.burntSienna,
          ),
        ),
      ),
    );
  }
}
