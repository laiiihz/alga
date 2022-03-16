import 'package:alga/constants/import_helper.dart';
import 'package:alga/extension/list_ext.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const AppTitle({Key? key, required this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconTheme(
        data: IconThemeData(
          color: isDark(context) ? Colors.white : Colors.black,
          size: 14,
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, maxLines: 1)),
            ...actions.sep(const SizedBox(width: 4)),
          ],
        ),
      ),
    );
  }
}

class AppTitleWrapper extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget child;
  final bool expand;
  const AppTitleWrapper(
      {Key? key,
      required this.title,
      required this.actions,
      required this.child,
      this.expand = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(title: title, actions: actions),
        const SizedBox(height: 4),
        expand ? Expanded(child: child) : child,
      ],
    );
  }
}
