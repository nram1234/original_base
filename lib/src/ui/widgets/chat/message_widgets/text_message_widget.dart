import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class TextMessageWidget extends StatelessWidget {
  final bool selfMessage;
  final String text;

  const TextMessageWidget({
    required this.selfMessage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: selfMessage ? Colors.white : Palette.burntSienna,
        border: selfMessage
            ? Border.all(
                color: Palette.linkWater,
                width: 2.0,
              )
            : null,
        borderRadius: BorderRadius.circular(
          SharedStyles.mediumComponentsRadius,
        ),
      ),
      child: Text(
        text,
        style: TextStyles.caption.copyWith(
          fontWeight: FontWeight.w500,
          color: selfMessage ? Palette.bigStone : Colors.white,
        ),
      ),
    );
  }
}
