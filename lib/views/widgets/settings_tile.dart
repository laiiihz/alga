import 'package:alga/constants/import_helper.dart';

class SettingsTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final ShapeBorder? shape;
  final VoidCallback? onTap;
  const SettingsTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.shape,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: trailing,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}
