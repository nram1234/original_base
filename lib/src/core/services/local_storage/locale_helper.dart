import 'dart:ui';
//---------------
import 'package:hive/hive.dart';
//------------------------------

class LocaleHelper {
  Box _cachedInfoBox = Hive.box("cached_info");

  /// returns stored locale on hive db.
  Locale? get storedLocale {
    String? langCode = _cachedInfoBox.get("lang_code");
    String? countryCode = _cachedInfoBox.get("country_code");
    if (langCode != null) {
      return Locale(langCode, countryCode);
    } else {
      return null;
    }
  }

  set storedLocale(Locale? newLocale) {
    _cachedInfoBox.put("lang_code", newLocale?.languageCode);
    _cachedInfoBox.put("country_code", newLocale?.countryCode);
  }
}
