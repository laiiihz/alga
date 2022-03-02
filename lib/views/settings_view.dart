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
      header: const PageHeader(
        title: Text('Settings'),
      ),
      content: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          final item = FluentIcons.allIcons.entries.toList()[index];
          return Column(
            children: [
              Icon(item.value),
              Text(item.key),
            ],
          );
        },
        itemCount: FluentIcons.allIcons.length,
      ),
    );
  }
}
