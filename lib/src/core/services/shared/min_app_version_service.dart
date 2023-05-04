import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
//--------------------------------------------------------
import 'package:original_base/src/ui/widgets/popups/app_upgrade_alert.dart';
import 'package:original_base/src/core/models/original_app_type.dart';
//--------------------------------------------------------------------

class MinimumAppVersionService {
  final _firestore = FirebaseFirestore.instance;

  /// reference to "system_info" collection.
  CollectionReference get _systemInfo {
    return _firestore.collection("system_info");
  }

  void ensureAppVersionIsAboveMinimum({
    required OriginalAppType appType,
    required BuildContext context,
  }) {
    PackageInfo.fromPlatform().then((appPackageInfo) async {
      int appVersionCode = int.parse(appPackageInfo.buildNumber);

      // Get app min_version from firestore.
      try {
        var minVersionDocument = await _systemInfo.doc("$appType").get();
        int minVersion = minVersionDocument.get("min_version");

        // if condition is true, pop an irremovable
        // dialog to force user to upgrade his app.
        if (minVersion > appVersionCode) showAppUpgradeAlert(appType, context);
      } catch (_) {}
    });
  }
}
