import 'package:devtoys/extension/list_ext.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  const AppTitle({Key? key, required this.title, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        ...actions.sep(const SizedBox(width: 4)),
      ],
    );
  }
}

class AppTitleWrapper extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget child;
  const AppTitleWrapper(
      {Key? key,
      required this.title,
      required this.actions,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTitle(title: title, actions: actions),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
