import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/view_models/drawer_controller_provider.dart';
import 'package:original_base/src/ui/widgets/popups/interception_alert.dart';
//---------------------------------------------------------------------------

class DashboardWrapperPopScope extends StatelessWidget {
  final Widget child;

  final VoidCallback onBackToHomeRequest;

  const DashboardWrapperPopScope({
    required this.child,
    required this.onBackToHomeRequest,
  });

  @override
  Widget build(BuildContext context) {
    Duration oneSecond = const Duration(seconds: 1);
    DateTime? firstBackButtonPressTime;
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (firstBackButtonPressTime == null ||
            now.difference(firstBackButtonPressTime!) > oneSecond) {
          firstBackButtonPressTime = now;
          context.read(drawerControllerProvider).closeDrawer();
          this.onBackToHomeRequest();
          return Future.value(false);
        } else {
          bool cancelAppExit = await showInterceptionAlert(
            titleId: "#exit_app",
            messageId: "#exit_app_question",
            actionId: "#yes",
            context: context,
          );
          return Future.value(!cancelAppExit);
        }
      },
      child: child,
    );
  }
}
