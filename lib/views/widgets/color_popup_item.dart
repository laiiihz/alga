import 'package:alga/constants/import_helper.dart';

class ColorPopupItem extends PopupMenuEntry<Color> {
  final Color color;
  const ColorPopupItem(this.color, {super.key});
  @override
  State<StatefulWidget> createState() => _ColorPopupItemState();

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(value) => value == color;
}

class _ColorPopupItemState extends State<ColorPopupItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, widget.color);
        },
        child: const SizedBox(height: kMinInteractiveDimension),
      ),
    );
  }
}
