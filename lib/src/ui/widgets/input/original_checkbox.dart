import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class OriginalCheckbox extends StatelessWidget {
  final bool checked;

  final VoidCallback onPressed;

  const OriginalCheckbox({
    required this.checked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 28.0,
        width: 28.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SharedStyles.smallComponentsRadius,
          ),
          color: checked ? Palette.burntSienna : Palette.overlayColor,
        ),
        child: checked
            ? Center(
                child: SvgPicture.asset(
                  "assets/icons/check_mark.svg",
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
