import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/view_models/drawer_controller_provider.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class DrawerActionButton extends StatelessWidget {
  /// title id used to get title translation.
  final String titleId;

  final VoidCallback onAction;

  const DrawerActionButton({
    required this.titleId,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    String iconAssetName = titleId.replaceFirst("#", "") + ".svg";
    return SizedBox(
      height: 44.0,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Palette.fireBrick),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.0),
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 25.0),
            SvgPicture.asset(
              "assets/icons/$iconAssetName",
              width: 18.0,
              color: Colors.white,
            ),
            SizedBox(width: 30.0),
            Text(
              titleId.translate(context),
              textAlign: TextAlign.center,
              style: TextStyles.subtitle2.copyWith(
                height: 1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onPressed: () {
          context.read(drawerControllerProvider).closeDrawer();
          this.onAction();
        },
      ),
    );
  }
}
