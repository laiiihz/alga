import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';

class ToolViewConfig extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget trailing;
  final VoidCallback? onPressed;
  const ToolViewConfig(
      {Key? key,
      required this.title,
      required this.trailing,
      this.leading,
      this.subtitle,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        tileColor: isDark(context) ? Colors.grey[900] : Colors.grey[50],
      ),
    );
  }
}

class ToolViewWrapper extends StatelessWidget {
  /// normally a list of [ToolViewConfig]
  final List<Widget> children;

  const ToolViewWrapper({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTitle(title: S.of(context).configuration),
        const SizedBox(height: 8),
        ...children.sep(const SizedBox(height: 4)),
        const SizedBox(height: 8),
      ],
    );
  }
}
