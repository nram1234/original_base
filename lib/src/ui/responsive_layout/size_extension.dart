import 'package:original_base/src/ui/responsive_layout/responsive_layout.dart';
//-----------------------------------------------------------------------------

extension SizeExtension on num {
  ///[ResponsiveLayout.setWidth]
  double get w => ResponsiveLayout().setWidth(this);

  ///[ResponsiveLayout.setHeight]
  double get h => ResponsiveLayout().setHeight(this);

  ///[ResponsiveLayout.radius]
  double get r => ResponsiveLayout().radius(this);

  ///[ResponsiveLayout.setSp]
  double get sp => ResponsiveLayout().setSp(this);
}
