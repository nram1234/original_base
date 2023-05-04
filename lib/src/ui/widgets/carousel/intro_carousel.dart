import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
//----------------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class IntroCarousel extends StatelessWidget {
  final int numberOfElements;

  final ValueChanged<int> onPagedChanged;

  const IntroCarousel({
    required this.numberOfElements,
    required this.onPagedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(numberOfElements, (i) {
        int resourceIndex = i + 1;
        return Column(
          children: [
            Text(
              "#intro_headline_$resourceIndex".translate(context),
              textAlign: TextAlign.center,
              style: TextStyles.h4.copyWith(
                fontSize: 37.0.sp,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SvgPicture.asset(
                  "assets/images/intro_$resourceIndex.svg",
                ),
              ),
            ),
            Text(
              "#intro_description_$resourceIndex".translate(context),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyles.caption.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Palette.spunPearl,
              ),
            ),
          ],
        );
      }),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        height: double.infinity,
        onPageChanged: (i, _) => onPagedChanged(i),
      ),
    );
  }
}
