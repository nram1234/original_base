import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/app_localization.dart';
//----------------------------------------------------------------------------------

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final List<Locale> supportedLocales;

  const AppLocalizationDelegate(this.supportedLocales);

  @override
  bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization originalLocalization = AppLocalization(locale);
    await originalLocalization.load();
    return originalLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
