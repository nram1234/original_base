import 'package:flutter/material.dart';
//-------------------------------------

enum AnimatedDrawerState { hidden, visible }

/// animated drawer controller that manages drawer state.
class AnimatedDrawerController extends ValueNotifier<AnimatedDrawerState> {
  /// creates a controller with initial drawer state. (Hidden by default)
  AnimatedDrawerController([AnimatedDrawerState? value])
      : super(value ?? AnimatedDrawerState.hidden);

  /// current animation offset.
  late double _offsetValue;

  /// start position of drawer animation at given [AnimatedDrawerState].
  Offset? _startPosition;

  /// determines if user is currently dragging drawer with his finger.
  bool _movementCaptured = false;

  /// toggles drawer.
  void toggleDrawer() {
    if (value == AnimatedDrawerState.hidden) {
      openDrawer();
    } else {
      closeDrawer();
    }
  }

  /// shows the drawer.
  void openDrawer() {
    if (value == AnimatedDrawerState.hidden) {
      value = AnimatedDrawerState.visible;
    }
  }

  /// hides the drawer.
  void closeDrawer() {
    if (value == AnimatedDrawerState.visible) {
      value = AnimatedDrawerState.hidden;
    }
  }

  /// this method is triggered when the user starts to swipe the screen to open
  /// or close the drawer.
  void handleDragStart({
    required bool isRTL,
    required double screenWidth,
    required double drawerOpenRatio,
    required double animationValue,
    required DragStartDetails details,
  }) {
    // don't execute if the drawer is hidden.
    if (value == AnimatedDrawerState.hidden) return;

    // position of the start point of parent left edge in x axis.
    double parentEdgeOffset;

    // if text direction is RTL then use the right edge of parent.
    if (isRTL) {
      parentEdgeOffset = screenWidth * drawerOpenRatio;
    } else {
      // else use left edge instead.
      parentEdgeOffset = screenWidth * (1.0 - drawerOpenRatio);
    }

    // position of the start point of drawer in x axis.
    double drawerOffset = screenWidth - parentEdgeOffset;

    // position of the start point of user drag area in x axis.
    double dragOffset = details.globalPosition.dx;

    bool userTappingOutsideParentEdge;
    // if text direction is RTL then check the right edge of parent.
    if (isRTL) {
      userTappingOutsideParentEdge = dragOffset < parentEdgeOffset;
    } else {
      // else check the left edge instead.
      userTappingOutsideParentEdge = dragOffset > parentEdgeOffset;
    }

    bool userTappingInsideDrawer;
    // if text direction is RTL then check the right side of drawer.
    if (isRTL) {
      userTappingInsideDrawer = dragOffset > drawerOffset;
    } else {
      // else check the left edge instead.
      userTappingInsideDrawer = dragOffset < drawerOffset;
    }

    if (value == AnimatedDrawerState.hidden && userTappingOutsideParentEdge ||
        value == AnimatedDrawerState.visible && userTappingInsideDrawer) {
      _movementCaptured = false;
    } else {
      _movementCaptured = true;
      _startPosition = details.globalPosition;
      _offsetValue = animationValue;
    }
  }

  /// this method is triggered when the user is holding his finger with
  /// swiping the screen to continue opening or closing the drawer.
  /// note that this method returns expected animation value change as double
  /// or returns null if it doesn't need to change.
  double? handleDragUpdate({
    required bool isRTL,
    required double screenWidth,
    required double drawerOpenRatio,
    required DragUpdateDetails details,
  }) {
    // don't execute if the drawer is hidden
    // or the movement isn't captured anyway.
    if (!_movementCaptured || value == AnimatedDrawerState.hidden) return null;

    // momentary position of user touch.
    Offset _momentaryPosition = details.globalPosition;

    // difference between current touch position and start position of
    // the animation in x axis.
    double diff = (_momentaryPosition - _startPosition!).dx;

    // momentary change required to the drawer position in the x axis.
    double requiredChangeOffset = (diff / (screenWidth * drawerOpenRatio));

    // if text direction is RTL then calculate remainingWidth based on
    // the left direction instead.
    if (isRTL) requiredChangeOffset = -requiredChangeOffset;

    // returns new dragging animation value.
    return _offsetValue + requiredChangeOffset;
  }

  /// this method is triggered when the user ends his finger dragging.
  void handleDragEnd({
    required double animationValue,
    required DragEndDetails details,
    required VoidCallback onDrawerOpened,
    required VoidCallback onDrawerClosed,
  }) {
    // don't execute if the drawer is hidden
    // or the movement isn't captured anyway.
    if (!_movementCaptured || value == AnimatedDrawerState.hidden) return;

    this.onDragOver();

    // if user has reached half of dragging journey or more and then left off
    // then skip the dragging animation.
    if (animationValue >= 0.5) {
      openDrawer();
      if (value == AnimatedDrawerState.visible) onDrawerOpened();
    } else {
      closeDrawer();
      if (value == AnimatedDrawerState.hidden) onDrawerClosed();
    }
  }

  /// this method is triggered when the user cancels his finger dragging.
  void onDragOver() {
    // don't execute if the drawer is hidden
    // and drag functionality isn't working.
    if (value == AnimatedDrawerState.hidden) return null;

    // declare that user dragging event is over.
    _movementCaptured = false;
    _startPosition = null;
  }
}
