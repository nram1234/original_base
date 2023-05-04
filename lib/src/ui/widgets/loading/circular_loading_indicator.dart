import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class CircularLoadingIndicator extends StatelessWidget {
  final double? loadingValue;
  final double? size;

  const CircularLoadingIndicator({
    this.loadingValue,
    this.size = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          color: Palette.burntSienna,
          value: loadingValue,
        ),
      ),
    );
  }
}
