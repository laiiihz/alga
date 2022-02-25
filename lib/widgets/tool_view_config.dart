import 'package:fluent_ui/fluent_ui.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget trailing;
  const ToolViewConfig({Key? key, required this.title, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: title,
      leading: const Icon(FluentIcons.add),
      trailing: trailing,
      tileColor: Colors.grey[160],
    );
  }
}
