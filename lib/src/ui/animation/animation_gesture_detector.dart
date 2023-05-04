import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//-------------------------------------
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class AnimationGestureDetector extends GestureDetector {
  final bool disabled;

  /// A [ChangeNotifier] that holds a single value
  /// which will be used to trigger the [child] animation.
  final ValueNotifier<bool> valueNotifier;

  final VoidCallback onTouch;

  /// The gestures that this widget will attempt to recognize.
  final Map<Type, GestureRecognizerFactory> gestures = {};

  /// The widget where the user touch will take place.
  final Widget child;

  AnimationGestureDetector({
    this.disabled = false,
    required this.valueNotifier,
    required this.onTouch,
    required this.child,
  });

  void setGestures() {
    gestures[TapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(debugOwner: this),
      (TapGestureRecognizer instance) {
        instance
          ..onTap = onTouch
          ..onTapDown = (_) {
            // notify listeners that user has just tapped on child.
            valueNotifier.value = true;
          }
          ..onTapUp = (_) {
            // remove selection effect of child after a short time
            // so that the user can notice change.
            Future.delayed(SharedStyles.animationDuration, () {
              valueNotifier.value = false;
            });
          }
          ..onTapCancel = () {
            // cancel tap effect if user cancels his touch.
            if (valueNotifier.value == true) {
              valueNotifier.value = false;
            }
          };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!disabled) setGestures();
    return RawGestureDetector(
      gestures: this.gestures,
      behavior: super.behavior,
      excludeFromSemantics: super.excludeFromSemantics,
      child: this.child,
    );
  }
}
