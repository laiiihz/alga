import 'package:flutter/material.dart';

import 'generated/app.translation.g.dart';

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
}

extension L10nX on BuildContext {
  AppLocalizations get tr => S.of(this);

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
