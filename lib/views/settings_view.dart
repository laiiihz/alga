import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';
import 'package:alga/utils/hive_adapters/theme_mode_adapter.dart'
    as theme_mode_adapter;
import 'package:alga/utils/hive_boxes/theme_box.dart';
import 'package:alga/utils/hive_util.dart';
import 'package:alga/views/widgets/expandable_settings_tile.dart';
import 'package:alga/views/widgets/settings_tile.dart';
import 'package:alga/widgets/box_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ToolView(
      title: Text(S.of(context).settings),
      content: ListView(
        children: <Widget>[
          AppTitle(title: S.of(context).about),
          SettingsTile(
            leading: Image.asset('assets/logo/256.webp'),
            title: Text(S.of(context).appName),
          ),
          SettingsTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Theme Mode'),
            trailing: BoxBuilder(
              box: HiveUtil.themeBox,
              builder: (context, box) {
                return PopupMenuButton<theme_mode_adapter.ThemeMode>(
                  itemBuilder: (context) {
                    return theme_mode_adapter.ThemeMode.values
                        .map((e) => PopupMenuItem(
                            child: Text(e.getName(context)), value: e))
                        .toList();
                  },
                  initialValue: ThemeBox.themeMode.theThemeMode,
                  onSelected: (item) {
                    ThemeBox.setThemeMode(
                        theme_mode_adapter.ThemeModeModel(theThemeMode: item));
                    setState(() {});
                  },
                  child: Text(ThemeBox.themeMode.theThemeMode.name),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          ExpandableSettingsTile(
            title: const Text('Links'),
            leading: const Icon(Icons.link),
            child: Column(
              children: [
                ListTile(
                  title: const Text('github'),
                  onTap: () {
                    launch('https://github.com/laiiihz/alga');
                  },
                ),
                ListTile(
                  title: const Text('LICENSES'),
                  onTap: () {
                    showLicensePage(context: context);
                  },
                ),
                ListTile(
                  title: const Text('issues'),
                  onTap: () {
                    launch('https://github.com/laiiihz/alga/issues');
                  },
                ),
              ],
            ),
          ),
        ].sep(const SizedBox(height: 4)),
      ),
    );
  }
}
