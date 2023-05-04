import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/ui/responsive_layout/responsive_layout.dart';
//-----------------------------------------------------------------------------

/// A helper widget that initializes [ResponsiveUtil].
class ResponsiveLayoutInitializer extends StatelessWidget {
  ResponsiveLayoutInitializer({
    required this.draftDesignSize,
    required this.builder,
  });

  /// The [Size] of the device in the design draft, in dp.
  final Size draftDesignSize;

  /// a function that builds the widgets tree below this widget.
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (_, Orientation orientation) {
            if (constraints.maxWidth != 0) {
              ResponsiveLayout.init(
                constraints,
                designSize: draftDesignSize,
              );
              return builder();
            }
            return Container();
          },
        );
      },
    );
  }
}
