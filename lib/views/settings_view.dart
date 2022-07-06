import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:alga/widgets/app_show_menu.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:alga/views/widgets/color_popup_item.dart';
import 'package:alga/views/widgets/expandable_settings_tile.dart';
import 'package:alga/views/widgets/settings_tile.dart';
import 'package:alga/widgets/box_builder.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  static const String _buildName = String.fromEnvironment('FLUTTER_BUILD_NAME');
  static const String _buildNumber =
      String.fromEnvironment('FLUTTER_BUILD_NUMBER');
  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: Text(S.of(context).settings),
      content: ListView(
        children: <Widget>[
          SettingsTile(
            leading: Image.asset('assets/logo/256.webp', height: 32, width: 32),
            title: Text(S.of(context).appName),
          ),
          ValueListenableBuilder(
            valueListenable: AppConfigBox.key(AppConfigType.themeMode),
            builder: (context, _, __) {
              return AppShowMenu<ThemeMode>(
                items: ThemeMode.values
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e.getName(context)),
                        ))
                    .toList(),
                initialValue: AppConfigBox.themeMode,
                onSelected: (item) {
                  AppConfigBox.themeMode = item;
                },
                childBuilder: (context, open) {
                  return SettingsTile(
                    onTap: open,
                    leading: const Icon(Icons.dark_mode),
                    title: Text(S.of(context).themeMode),
                    trailing: Text(AppConfigBox.themeMode.getName(context)),
                  );
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: AppConfigBox.key(AppConfigType.locale),
            builder: (context, _, __) {
              return AppShowMenu<String>(
                items: AppConfigBox.localCodes.map((e) {
                  return PopupMenuItem(
                    value: e,
                    child: Text(S.getlang(context, e)),
                  );
                }).toList(),
                initialValue: AppConfigBox.localeValue,
                onSelected: (item) {
                  AppConfigBox.localeValue = item;
                },
                childBuilder: (context, open) {
                  return SettingsTile(
                    onTap: open,
                    leading: const Icon(Icons.language),
                    title: Text(S.of(context).language),
                    trailing:
                        Text(S.getlang(context, AppConfigBox.localeValue)),
                  );
                },
              );
            },
          ),
          ValueListenableBuilder(
              valueListenable: AppConfigBox.key(AppConfigType.themeColor),
              builder: (context, _, __) {
                return AppShowMenu<Color>(
                  items: Colors.primaries.map((e) {
                    return ColorPopupItem(e);
                  }).toList(),
                  onSelected: (item) {
                    AppConfigBox.themeColor = item;
                  },
                  initialValue: AppConfigBox.themeColor,
                  childBuilder: (context, open) {
                    return SettingsTile(
                      onTap: open,
                      leading: const Icon(Icons.color_lens),
                      title: Text(S.of(context).themeColor),
                      trailing: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConfigBox.themeColor,
                        ),
                      ),
                    );
                  },
                );
              }),
          const SizedBox(height: 8),
          ExpandableSettingsTile(
            title: Text(S.of(context).links),
            leading: const Icon(Icons.link),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code_rounded),
                  title: Text(S.of(context).github),
                  onTap: () {
                    launchUrlString('https://github.com/laiiihz/alga');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.copyright),
                  title: Text(S.of(context).licenses),
                  onTap: () {
                    showLicensePage(context: context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report_rounded),
                  title: Text(S.of(context).issues),
                  onTap: () {
                    launchUrlString('https://github.com/laiiihz/alga/issues');
                  },
                ),
              ],
            ),
          ),
          SettingsTile(
            leading: const Icon(Icons.info_rounded),
            title: Text(S.of(context).version),
            trailing: const Chip(
              label: Text(
                '$_buildName+$_buildNumber',
              ),
            ),
          ),
        ].sep(const SizedBox(height: 4)),
      ),
    );
  }
}
