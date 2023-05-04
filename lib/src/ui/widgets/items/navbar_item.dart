import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class NavBarItem extends StatelessWidget {
  final bool isSelected;

  /// title id used to get title translation.
  final String titleId;

  late final String iconAssetName;

  final VoidCallback onTap;

  NavBarItem({
    required this.isSelected,
    required this.titleId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    iconAssetName = titleId.replaceFirst("#", "") + ".svg";
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/$iconAssetName",
            height: 20.0,
            width: 20.0,
            color: isSelected ? Palette.burntSienna : null,
          ),
          SizedBox(height: 3.0),
          Text(
            titleId.translate(context),
            style: TextStyles.caption.copyWith(
              fontWeight: FontWeight.w500,
              color: isSelected ? Palette.burntSienna : Palette.shuttleGray,
            ),
          ),
        ],
      ),
    );
  }
}
