import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class SocialButton extends StatelessWidget {
  final bool showElevation;

  final String iconName;

  final VoidCallback? onPressed;

  const SocialButton({
    this.showElevation = true,
    required this.iconName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(showElevation ? 5.0 : 0.0),
          shadowColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Palette.overlayColor),
        ),
        child: SvgPicture.asset(
          "assets/icons/$iconName.svg",
          height: 24.0,
          width: 24.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
