import 'package:fluent_ui/fluent_ui.dart';

class ToolbarConfig extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;

  const ToolbarConfig({
    Key? key,
    required this.title,
    this.subtitle = '',
    this.leading = const SizedBox.shrink(),
    this.trailing = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: leading,
      trailing: trailing,
    );
  }
}
