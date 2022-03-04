import 'package:devtoys/constants/import_helper.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(title: Text(S.of(context).settings)),
      content: ListView(
        children: [
          AppTitle(title: S.of(context).about),
          ListTile(
            leading: Image.asset('assets/logo/256x256.webp'),
            title: Text(S.of(context).appName),
          ),
        ],
      ),
    );
  }
}
