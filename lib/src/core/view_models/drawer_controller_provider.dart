import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/view_models/animated_drawer_controller.dart';
//------------------------------------------------------------------------------

final drawerControllerProvider = Provider<AnimatedDrawerController>((_) {
  return AnimatedDrawerController();
});
