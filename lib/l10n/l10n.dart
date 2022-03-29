import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/s.dart';

import 'package:alga/utils/hive_adapters/system_settings_model.dart';

class S {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context) ??
        lookupAppLocalizations(const Locale('zh'));
  }

  static List<LocalizationsDelegate> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static String getlang(BuildContext context, String localeCode) {
    switch (localeCode) {
      case SystemSettingsModel.localSystem:
        return of(context).followSystem;
      case SystemSettingsModel.localChinese:
        return '简体中文';
      case SystemSettingsModel.localEnglish:
        return 'English';
      default:
        return 'UNKNOWN';
    }
  }
}
