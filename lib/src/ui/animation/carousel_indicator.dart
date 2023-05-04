import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src//config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class CarouselIndicator extends StatelessWidget {
  final int activeIndex;

  /// number of images shown in the carousel.
  final int numberOfImages;

  const CarouselIndicator({
    required this.activeIndex,
    required this.numberOfImages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfImages, (i) {
        return AnimatedContainer(
          duration: SharedStyles.animationDuration,
          width: 21.0,
          height: 7.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(
              SharedStyles.largeComponentsRadius,
            ),
            color: i == activeIndex ? Palette.burntSienna : Colors.white,
          ),
        );
      }),
    );
  }
}
