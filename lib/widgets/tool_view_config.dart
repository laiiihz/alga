import 'package:fluent_ui/fluent_ui.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget trailing;
  const ToolViewConfig(
      {Key? key,
      required this.title,
      required this.trailing,
      this.leading,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      tileColor: Colors.grey[160],
    );
  }
}
