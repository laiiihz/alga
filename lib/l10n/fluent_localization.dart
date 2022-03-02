import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class ZhFluentLocalization implements FluentLocalizations {
  const ZhFluentLocalization();

  @override
  String get backButtonTooltip => '返回';

  @override
  String get closeButtonLabel => '关闭';

  @override
  String get searchLabel => '搜索';

  @override
  String get closeNavigationTooltip => '关闭导航栏';

  @override
  String get openNavigationTooltip => '打开导航栏';

  @override
  String get clickToSearch => '点击搜索';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get minimizeWindowTooltip => 'Minimze';

  @override
  String get restoreWindowTooltip => 'Restore';

  @override
  String get closeWindowTooltip => '关闭';

  @override
  String get dialogLabel => '对话框';

  @override
  String get newTabLabel => '添加新标签页';

  @override
  String get closeTabLabel => '关闭标签页 (Ctrl+F4)';

  @override
  String get scrollTabBackwardLabel => 'Scroll tab list backward';

  @override
  String get scrollTabForwardLabel => 'Scroll tab list forward';

  @override
  String get noResultsFoundLabel => '找不到结果';

  @override
  String get copyActionLabel => '复制';

  @override
  String get copyActionTooltip => '复制';

  @override
  String get copyShortcut => '';

  @override
  String get cutActionLabel => '';

  @override
  String get cutActionTooltip => '';

  @override
  // TODO: implement cutShortcut
  String get cutShortcut => '';

  @override
  // TODO: implement pasteActionLabel
  String get pasteActionLabel => '';

  @override
  // TODO: implement pasteActionTooltip
  String get pasteActionTooltip => '';

  @override
  // TODO: implement pasteShortcut
  String get pasteShortcut => '';

  @override
  // TODO: implement selectAllActionLabel
  String get selectAllActionLabel => '';

  @override
  // TODO: implement selectAllActionTooltip
  String get selectAllActionTooltip => '';

  @override
  // TODO: implement selectAllShortcut
  String get selectAllShortcut => '';

  /// Creates an object that provides US English resource values for the material
  /// library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [MaterialApp] does so by default.
  static Future<FluentLocalizations> load(Locale locale) {
    return SynchronousFuture(lookupAppLocalizations(locale));
  }

  static const LocalizationsDelegate<FluentLocalizations> delegate =
      _CustomFluentLocalizationsDelegate();

  static FluentLocalizations lookupAppLocalizations(Locale locale) {
    // Lookup logic when only language code is specified.
    switch (locale.languageCode) {
      case 'en':
        return const DefaultFluentLocalizations();
      case 'zh':
        return const ZhFluentLocalization();
    }

    throw FlutterError(
        'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
        'an issue with the localizations generation tool. Please file an issue '
        'on GitHub with a reproducible sample app and the gen-l10n configuration '
        'that was used.');
  }
}

class _CustomFluentLocalizationsDelegate
    extends LocalizationsDelegate<FluentLocalizations> {
  const _CustomFluentLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'en' || locale.languageCode == 'zh';

  @override
  Future<FluentLocalizations> load(Locale locale) =>
      ZhFluentLocalization.load(locale);

  @override
  bool shouldReload(_CustomFluentLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultFluentLocalizations.delegate(en_US)';
}
