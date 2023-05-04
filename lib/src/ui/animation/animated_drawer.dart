import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/view_models/animated_drawer_controller.dart';
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class AnimatedDrawer extends StatefulWidget {
  /// determines if the text direction of the app is Right to Left.
  final bool textDirectionIsRTL;

  /// ratio between width of drawer and its [parent] when the drawer is open.
  final double openRatio;

  final Color? drawerBackgroundColor;

  /// animation duration.
  final Duration animationDuration;

  /// animation curve.
  final Curve? animationCurve;

  /// set it to an AnimatedController so that you control the state
  /// of the drawer
  final AnimatedDrawerController animatedDrawerController;

  /// widget that represent drawer parent screen.
  final Widget parent;

  /// specifies drawer content.
  final Widget drawer;

  const AnimatedDrawer({
    Key? key,
    required this.textDirectionIsRTL,
    this.openRatio = 0.5,
    this.drawerBackgroundColor,
    this.animationDuration = SharedStyles.animationDuration,
    this.animationCurve,
    required this.animatedDrawerController,
    required this.parent,
    required this.drawer,
  }) : super(key: key);

  @override
  _AnimatedDrawerState createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late AnimatedDrawerController _drawerController;
  late AnimationController _animationController;
  late Animation<double> drawerScalingAnimation;

  // gets the maximum offset which the drawer can have.
  double getMaxOffset(BoxConstraints constraints) {
    return widget.textDirectionIsRTL
        ? -(constraints.maxWidth * widget.openRatio)
        : constraints.maxWidth * widget.openRatio;
  }

  @override
  void initState() {
    super.initState();
    // initialize animated drawer notifier and trigger animation
    // whenever the drawer state change.
    _drawerController = widget.animatedDrawerController;
    _drawerController.addListener(() {
      _drawerController.value == AnimatedDrawerState.visible
          ? _animationController.forward()
          : _animationController.reverse();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: _drawerController.value == AnimatedDrawerState.visible ? 1.0 : 0.0,
    );

    drawerScalingAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: widget.drawerBackgroundColor ?? Theme.of(context).primaryColor,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails details) {
          _drawerController.handleDragStart(
            isRTL: widget.textDirectionIsRTL,
            screenWidth: screenWidth,
            drawerOpenRatio: widget.openRatio,
            animationValue: _animationController.value,
            details: details,
          );
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          double? newAnimationVal = _drawerController.handleDragUpdate(
            isRTL: widget.textDirectionIsRTL,
            screenWidth: screenWidth,
            drawerOpenRatio: widget.openRatio,
            details: details,
          );
          if (newAnimationVal != null) {
            _animationController.value = newAnimationVal;
          }
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          _drawerController.handleDragEnd(
            animationValue: _animationController.value,
            details: details,
            onDrawerOpened: () => _animationController.animateTo(1),
            onDrawerClosed: () => _animationController.animateTo(0),
          );
        },
        onHorizontalDragCancel: _drawerController.onDragOver,
        child: LayoutBuilder(
          builder: (_, constraints) {
            double maxOffset = getMaxOffset(constraints);
            Animation<Offset> screenTranslateTween = Tween<Offset>(
              begin: Offset(0.0, 0.0),
              end: Offset(maxOffset, 0.0),
            ).animate(
              widget.animationCurve != null
                  ? CurvedAnimation(
                      parent: _animationController,
                      curve: widget.animationCurve!,
                    )
                  : _animationController,
            );

            return Stack(
              children: <Widget>[
                // --- Drawer
                FractionallySizedBox(
                  widthFactor: widget.openRatio,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, Widget? drawer) {
                      return Transform.scale(
                        scale: drawerScalingAnimation.value,
                        child: drawer,
                      );
                    },
                    child: widget.drawer,
                  ),
                ),
                // --- Parent
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, parent) {
                    return Transform.translate(
                      offset: screenTranslateTween.value,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration.lerp(
                          const BoxDecoration(
                            boxShadow: const [],
                            borderRadius: BorderRadius.zero,
                          ),
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              SharedStyles.largeComponentsRadius,
                            ),
                          ),
                          _animationController.value,
                        ),
                        child: parent,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      widget.parent,
                      ValueListenableBuilder(
                        valueListenable: _drawerController,
                        builder: (_, value, __) {
                          return value == AnimatedDrawerState.visible
                              ? Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _drawerController.closeDrawer();
                                    },
                                    highlightColor: Colors.transparent,
                                    child: Container(),
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
