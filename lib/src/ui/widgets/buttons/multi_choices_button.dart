import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/animation/animation_gesture_detector.dart';
import 'package:original_base/src/ui/widgets/popups/snack_bar_alert.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class MultiChoicesButton extends StatelessWidget {
  final bool disabledButton;

  final String? selectedChoice;

  /// id used to translate hint text.
  final String hintTextId;

  /// id used to translate warning message
  /// when the button is disabled.
  final String warningMessageId;

  final TextDirection? textDirection;

  final VoidCallback onPressed;

  const MultiChoicesButton({
    this.disabledButton = false,
    this.selectedChoice,
    required this.hintTextId,
    this.warningMessageId = "",
    this.textDirection,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final chooserTappedNotifier = ValueNotifier<bool>(false);
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          if (disabledButton) {
            showSnackBarAlert(
              warningMessageId,
              context,
              durationInSeconds: 1,
            );
          }
        },
        child: AnimationGestureDetector(
          disabled: disabledButton,
          valueNotifier: chooserTappedNotifier,
          onTouch: () {
            FocusScope.of(context).unfocus();
            this.onPressed();
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: chooserTappedNotifier,
            builder: (_, buttonTapped, __) {
              return Container(
                height: 49.0,
                decoration: BoxDecoration(
                  color: Palette.solitude,
                  borderRadius: BorderRadius.circular(
                    SharedStyles.smallComponentsRadius,
                  ),
                  border: buttonTapped
                      ? Border.all(
                          color: Palette.burntSienna,
                          width: 1.5,
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SharedStyles.componentsPadding,
                    horizontal: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          selectedChoice ?? hintTextId.translate(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: textDirection,
                          style: TextStyles.body2.copyWith(
                            height: 1.0,
                            color: selectedChoice != null
                                ? Palette.bigStone
                                : Palette.spunPearl,
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: context.isRTL ? 0 : 2,
                        child: SvgPicture.asset(
                          "assets/icons/forward_arrow.svg",
                          height: 14.0,
                          width: 14.0,
                          color: Palette.bigStone,
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
