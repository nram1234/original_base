import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class DiscountBanner extends StatelessWidget {
  final int discountPercent;

  const DiscountBanner(this.discountPercent);

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: Directionality.of(context),
      start: 10.0,
      top: 7.0,
      child: Container(
        height: 20.0,
        width: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SharedStyles.smallComponentsRadius,
          ),
          color: Palette.burntSienna,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$discountPercent%",
              style: TextStyles.overline.copyWith(
                height: 1.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 3),
            Text(
              "#discount".translate(context),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: TextStyles.overline.copyWith(
                height: 1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
