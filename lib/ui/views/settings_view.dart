import 'package:alga/ui/widgets/alga_logo.dart';
import 'package:alga/ui/widgets/app_show_menu.dart';
import 'package:alga/ui/widgets/setting_title.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/hive_boxes/app_config_box.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsView();
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
          Consumer(
            builder: (context, ref, child) {
              return AppShowMenu<ThemeMode>(
                items: ThemeMode.values
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e.getName(context)),
                        ))
                    .toList(),
                initialValue: ref.watch(appThemeModeProvider),
                onSelected: (item) {
                  ref.read(appThemeModeProvider.notifier).change(item);
                },
                childBuilder: (context, open) {
                  return ListTile(
                    onTap: open,
                    leading: const Icon(Icons.dark_mode),
                    title: Text(context.tr.themeMode),
                    trailing: Text(
                      ref.watch(appThemeModeProvider).getName(context),
                    ),
                  );
                },
              );
            },
          ),
          Consumer(
            builder: (context, ref, _) {
              return AppShowMenu<Locale?>(
                items: [
                  PopupMenuItem(
                    value: null,
                    onTap: () {
                      ref.read(appLocaleProvider.notifier).change(null);
                    },
                    child: Text(context.tr.followSystem),
                  ),
                  ...S.supportedLocales.map((e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(e.getName(context)),
                    );
                  }),
                ],
                initialValue: ref.watch(appLocaleProvider),
                childBuilder: (context, open) {
                  return ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(context.tr.language),
                    trailing:
                        Text(ref.watch(appLocaleProvider).getName(context)),
                    onTap: open,
                  );
                },
                onSelected: (t) {
                  ref.read(appLocaleProvider.notifier).change(t);
                },
              );
            },
          ),
          if (isDark(context))
            Consumer(
              builder: (context, ref, _) {
                return SwitchListTile(
                  secondary: const Icon(Icons.night_shelter_rounded),
                  title: Text(context.tr.pureBlack),
                  value: ref.watch(pureBlackBackgroundProvider),
                  onChanged: (t) {
                    ref.read(pureBlackBackgroundProvider.notifier).change(t);
                  },
                );
              },
            ),
          Consumer(
            builder: (context, ref, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.grid_view_rounded),
                title: Text(context.tr.gridLayout),
                value: ref.watch(useGridLayoutProvider),
                onChanged: (t) {
                  ref.read(useGridLayoutProvider.notifier).change(t);
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
          AboutListTile(
            icon: const AlgaLogo(radius: 24),
            applicationName: context.tr.appName,
            applicationIcon: const AlgaLogo(radius: 24),
            applicationLegalese: 'MIT',
            applicationVersion:
                '${context.tr.version}$_buildName+$_buildNumber',
            aboutBoxChildren: [],
          ),
        ])),
      ],
    );
    result = Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: result,
    );
    return result;
  }
}
