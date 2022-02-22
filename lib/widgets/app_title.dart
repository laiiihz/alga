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
        ...actions,
      ],
    );
  }
}
