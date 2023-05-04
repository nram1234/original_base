import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackArrow;

  final String title;

  final Widget? trailing;

  const ScreenHeader({
    this.showBackArrow = true,
    required this.title,
    this.trailing,
  });

  @override
  Size get preferredSize {
    return Size.fromHeight(SharedStyles.screenHeaderHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Palette.burntSienna,
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              title,
              style: TextStyles.subtitle1.copyWith(
                height: 1.0,
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamilies.almarai,
              ),
            ),
            leading: showBackArrow
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      context.isRTL
                          ? "assets/icons/right_arrow.svg"
                          : "assets/icons/left_arrow.svg",
                      color: Colors.white,
                      height: 20.0,
                      width: 20.0,
                    ),
                    onPressed: () => Sailor.back(),
                  )
                : null,
            actions: trailing != null ? [trailing!] : null,
          ),
        ],
      ),
    );
  }
}
