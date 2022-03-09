import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';
import 'package:alga/views/widgets/expandable_settings_tile.dart';
import 'package:alga/views/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
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
                  title: const Text('licenses'),
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
