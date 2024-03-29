import 'package:flutter/material.dart';

import 'generated/app.translation.g.dart';

class S {
  static List<LocalizationsDelegate> get localizationsDelegates =>
      AppLocalizations.localizationsDelegates;

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;
}

extension L10nX on BuildContext {
  AppLocalizations get tr =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('zh'));

  MaterialLocalizations get mtr => MaterialLocalizations.of(this);
}

extension LocaleExt on Locale? {
  String getName(BuildContext context) {
    switch (this) {
      case const Locale('zh', null):
        return '简体中文';
      case const Locale('en', null):
        return 'English';
      case const Locale('ja', null):
        return '日本語';
      default:
        return context.tr.followSystem;
    }
  }
}
