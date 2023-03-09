import 'package:alga/utils/constants/import_helper.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.tooltip,
    required this.onPressed,
    this.color,
    required this.icon,
  });
  final String tooltip;
  final VoidCallback? onPressed;
  final Color? color;
  final Widget icon;

  bool get _enabled => onPressed != null;
  @override
  Widget build(BuildContext context) {
    Color themeColor = color ?? Theme.of(context).colorScheme.primary;
    return Tooltip(
      message: tooltip,
      child: InkResponse(
        customBorder: const StadiumBorder(),
        onTap: onPressed,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconTheme(
            data: IconTheme.of(context).copyWith(
              color:
                  _enabled ? themeColor : Theme.of(context).colorScheme.outline,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}
