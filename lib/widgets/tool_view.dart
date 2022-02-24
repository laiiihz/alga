import 'package:devtoys/extension/list_ext.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ToolView extends StatelessWidget {
  final Widget title;
  final Widget content;
  const ToolView({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  ToolView.scrollVertical({
    Key? key,
    EdgeInsets? padding,
    required this.title,
    required List<Widget> children,
  })  : content = ListView(
          children: children.sep(const SizedBox(height: 8)),
          padding: padding,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(title: title),
      content: content,
    );
  }
}
