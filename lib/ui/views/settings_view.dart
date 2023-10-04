import 'package:alga/routers/app_router.dart';
import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:alga/ui/widgets/setting_title.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:alga/utils/constants/import_helper.dart';

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsView();
  }
}

class LicensesRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LicensePage();
  }
}

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
    Widget result = CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(S.of(context).settings),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SettingTitle(Text(context.tr.lookAndFeel)),
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
                  return ListTile(
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
                  return ListTile(
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
          SettingTitle(Text(context.tr.about)),
          ListTile(
            leading: const Icon(Icons.code_rounded),
            title: Text(S.of(context).github),
            onTap: () {
              launchUrlString(
                'https://github.com/laiiihz/alga',
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bug_report_rounded),
            title: Text(S.of(context).issues),
            onTap: () {
              launchUrlString(
                'https://github.com/laiiihz/alga/issues',
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded),
            title: Text(context.tr.licenses),
            onTap: () {
              LicensesRoute().go(context);
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/logo/256.webp',
              width: 28,
              height: 28,
            ),
            title: Text(context.tr.appName),
            subtitle: Text('${context.tr.version}$_buildName+$_buildNumber'),
          ),
        ])),
      ],
    );
    result = Material(child: result);
    return result;
  }
}
