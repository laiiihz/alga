import '../../utils/constants/import_helper.dart';

class AppShowMenu<T> extends StatelessWidget {
  const AppShowMenu({
    super.key,
    required this.items,
    required this.childBuilder,
    required this.initialValue,
    required this.onSelected,
  });
  final List<PopupMenuEntry<T>> items;
  final T? initialValue;
  final ValueChanged<T> onSelected;
  final Widget Function(BuildContext context, VoidCallback open) childBuilder;

  _showMenu(BuildContext context) async {
    final widget = context.findRenderObject()! as RenderBox;
    final offset = Offset(widget.size.width, 0);
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(offset, ancestor: overlay),
        widget.localToGlobal(widget.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final result = await showMenu(
      context: context,
      position: position,
      items: items,
      initialValue: initialValue,
    );
    if (result != null) {
      onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    showMenu() => _showMenu(context);
    return childBuilder(context, showMenu);
  }
}

class AppMenuWrapper<T> extends StatelessWidget {
  const AppMenuWrapper({
    super.key,
    required this.items,
    required this.childBuilder,
    required this.initialValue,
    required this.onSelected,
    required this.getName,
  });
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T> onSelected;
  final String Function(T e) getName;
  final Widget Function(BuildContext context, VoidCallback open) childBuilder;

  _showMenu(BuildContext context) async {
    final widget = context.findRenderObject()! as RenderBox;
    final offset = Offset(widget.size.width, 0);
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(offset, ancestor: overlay),
        widget.localToGlobal(widget.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final result = await showMenu(
      context: context,
      position: position,
      items: items
          .map((e) => PopupMenuItem(value: e, child: Text(getName(e))))
          .toList(),
      initialValue: initialValue,
    );
    if (result != null) {
      onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    showMenu() => _showMenu(context);
    return childBuilder(context, showMenu);
  }
}
