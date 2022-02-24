import 'package:fluent_ui/fluent_ui.dart';

class FormatterConfig extends StatelessWidget {
  final String title;
  final Widget trailing;
  const FormatterConfig({Key? key, required this.title, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: Text(title),
      leading: const Icon(FluentIcons.access_logo),
      trailing: trailing,
      tileColor: Colors.grey[160],
    );
  }
}
