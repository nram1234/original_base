import 'dart:io';
//---------------
import 'package:original_base/src/core/models/original_app_type.dart';
//--------------------------------------------------------------------

class Constants {
  static const _appStoreUrl = "https://apps.apple.com/ly/app";
  static const _googlePlayUrl = "https://play.google.com/store/apps/details";

  static const String customerAppLinkOnGooglePlay =
      "$_googlePlayUrl?id=com.original.customer";
  static const String customerAppLinkOnAppleStore =
      "$_appStoreUrl/original_customer/id1555859299";

  static const String dealerAppLinkOnGooglePlay =
      "$_googlePlayUrl?id=com.original.dealer";
  static const String dealerAppLinkOnAppleStore =
      "$_appStoreUrl/original_dealer/id1629996843";

  /// Gets the app store link depending on [appType] and [Platform].
  static String getStoreLinkFromAppType(OriginalAppType appType) {
    if (Platform.isAndroid) {
      return appType == OriginalAppType.customer
          ? customerAppLinkOnGooglePlay
          : dealerAppLinkOnGooglePlay;
    } else {
      return appType == OriginalAppType.customer
          ? customerAppLinkOnAppleStore
          : dealerAppLinkOnAppleStore;
    }
  }
}
