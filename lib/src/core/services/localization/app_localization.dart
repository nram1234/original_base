import 'dart:convert';
//--------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//-------------------------------------
import 'package:original_base/src/core/services/localization/localization_delegate.dart';
//---------------------------------------------------------------------------------------

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static LocalizationsDelegate getDelegate(List<Locale> supportedLocales) {
    return AppLocalizationDelegate(supportedLocales);
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(
      "assets/locales/${locale.languageCode}_${locale.countryCode}.json",
    );
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });
    return true;
  }

  String? translate(String key) => _localizedStrings[key];
}
