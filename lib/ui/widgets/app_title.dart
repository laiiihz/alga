import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/extension/list_ext.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const AppTitle({super.key, required this.title, this.actions});
  List<Widget> get _actions => actions ?? const <Widget>[];
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: isDark(context) ? Colors.white : Colors.black,
        size: 14,
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            maxLines: 1,
            style: const TextStyle(fontSize: 16),
          )),
          ..._actions.sep(const SizedBox(width: 4)),
        ],
      ),
    );
  }
}

class AppTitleWrapper extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  final bool expand;
  const AppTitleWrapper(
      {Key? key,
      required this.title,
      this.actions,
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
