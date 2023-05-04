import 'dart:io';
//---------------
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
//----------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
//-------------------------------------------------------------------------------------

Future<void> rateOnAppStore(
  BuildContext context, {
  required String appLinkOnGooglePlay,
  required String appLinkOnAppleStore,
}) async {
  String appLink = Platform.isIOS ? appLinkOnAppleStore : appLinkOnGooglePlay;
  Fluttertoast.showToast(
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
    msg: "#please_rate_app".translate(context),
  );
  await launch(appLink);
}
