import 'package:alga/constants/import_helper.dart';

class SettingsTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final ShapeBorder? shape;
  const SettingsTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = FluentTheme.of(context).brightness == Brightness.dark;
    return ListTile(
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      leading: leading,
      title: title,
      trailing: trailing,
      subtitle: subtitle,
      tileColor: isDark ? Colors.grey[160] : Colors.grey[20],
      isThreeLine: true,
    );
  }
}
