import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/animation/animation_gesture_detector.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/core/models/car/car_brand.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class CarBrandChoice extends StatelessWidget {
  final bool selected;

  final CarBrand carBrand;

  final VoidCallback onBrandPicked;

  const CarBrandChoice({
    this.selected = false,
    required this.carBrand,
    required this.onBrandPicked,
  });

  @override
  Widget build(BuildContext context) {
    final brandTappedNotifier = ValueNotifier<bool>(false);
    return AnimationGestureDetector(
      valueNotifier: brandTappedNotifier,
      onTouch: onBrandPicked,
      child: SizedBox(
        height: 125.0,
        child: ValueListenableBuilder<bool>(
          valueListenable: brandTappedNotifier,
          builder: (_, tapped, __) {
            return Card(
              margin: EdgeInsets.zero,
              elevation: tapped || selected ? 2.0 : 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SharedStyles.mediumComponentsRadius,
                ),
                side: BorderSide(
                  width: 1.0,
                  color: tapped || selected
                      ? Palette.burntSienna
                      : Palette.pattensBlue,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: getCachedImage(
                      carBrand.thumbnailUrl,
                      height: 50.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    carBrand.name[context.langCode],
                    style: TextStyles.subtitle2.copyWith(
                      color: Palette.shuttleGray,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
