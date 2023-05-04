import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/app_localization.dart';
//----------------------------------------------------------------------------------

extension tr on String {
  /// This method gets the translation of given translation id
  /// based on the current language of the app.
  String translate(BuildContext context) {
    AppLocalization? appLocalization = AppLocalization.of(context);
    return appLocalization!.translate(this) ?? "";
  }
}

extension appLanguage on BuildContext {
  /// This getter determines if text direction of the app
  /// is currently Right-to-Left.
  bool get isRTL {
    Locale appLocale = Localizations.localeOf(this);
    return appLocale.languageCode == "ar";
  }

  /// returns current language code.
  String get langCode {
    Locale appLocale = Localizations.localeOf(this);
    return appLocale.languageCode;
  }
}
