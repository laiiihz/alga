import 'package:fluent_ui/fluent_ui.dart';

class FormatterConfig extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget trailing;
  const FormatterConfig(
      {Key? key,
      required this.leading,
      required this.title,
      required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: Text(title),
      leading: leading,
      trailing: trailing,
      tileColor: Colors.grey[160],
    );
  }
}
