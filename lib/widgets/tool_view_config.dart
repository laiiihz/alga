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
    bool isDark = FluentTheme.of(context).brightness == Brightness.dark;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      isThreeLine: true,
      tileColor: isDark ? Colors.grey[160] : Colors.grey[20],
    );
  }
}
