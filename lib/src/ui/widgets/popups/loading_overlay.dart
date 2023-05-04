import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class LoadingOverlay extends StatelessWidget {
  /// determines whether to show this loading overlay or not.
  final bool inAsyncCall;

  final bool showBorderRadius;

  final Color? barrierColor;

  final Widget child;

  LoadingOverlay({
    required this.inAsyncCall,
    this.showBorderRadius = true,
    this.barrierColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return AbsorbPointer(
      absorbing: true,
      child: Stack(
        children: [
          child,
          ClipRRect(
            borderRadius: showBorderRadius
                ? BorderRadius.only(
                    topLeft: Radius.circular(
                      SharedStyles.largeComponentsRadius,
                    ),
                    topRight: Radius.circular(
                      SharedStyles.largeComponentsRadius,
                    ),
                  )
                : BorderRadius.zero,
            child: ModalBarrier(
              dismissible: false,
              color: barrierColor ?? Palette.overlayColor,
            ),
          ),
          CircularLoadingIndicator(),
        ],
      ),
    );
  }
}
