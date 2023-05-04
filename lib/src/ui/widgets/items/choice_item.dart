import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/animation/animation_gesture_detector.dart';
import 'package:original_base/src/core/utils/cached_image_util.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ChoiceItem extends StatelessWidget {
  final bool selected;

  final String choice;
  final String? imageUrl;

  final VoidCallback onChoicePicked;

  const ChoiceItem({
    this.selected = false,
    required this.choice,
    this.imageUrl,
    required this.onChoicePicked,
  });

  @override
  Widget build(BuildContext context) {
    final infoPickedNotifier = ValueNotifier<bool>(false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.0),
      child: AnimationGestureDetector(
        valueNotifier: infoPickedNotifier,
        onTouch: onChoicePicked,
        child: SizedBox(
          height: 58.0,
          child: ValueListenableBuilder<bool>(
            valueListenable: infoPickedNotifier,
            builder: (_, bool picked, __) {
              return Card(
                margin: EdgeInsets.zero,
                elevation: picked || selected ? 2.0 : 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  side: BorderSide(
                    width: 1.0,
                    color: Palette.pattensBlue,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SharedStyles.componentsPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (imageUrl != null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                SharedStyles.smallComponentsRadius,
                              ),
                              child: getCachedImage(
                                imageUrl!,
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                            SizedBox(width: 15.0),
                          ],
                          Text(
                            choice,
                            textAlign: context.isRTL
                                ? TextAlign.right
                                : TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: TextStyles.body1.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Palette.bigStone,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 28.0,
                        width: 28.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: picked || selected
                              ? Palette.kellyGreen
                              : Palette.whiteSmoke,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/check_mark.svg",
                            color: picked || selected
                                ? Colors.white
                                : Palette.gainsboro,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
