import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final String svg;
  final bool colorIcon;
  const SvgAssetIcon(this.svg, {Key? key, this.colorIcon = false})
      : super(key: key);

  Color? _color(BuildContext context) {
    final brightness = FluentTheme.of(context).brightness;
    if (colorIcon) return null;
    return brightness.isLight ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size;
    return SvgPicture.asset(
      svg,
      width: iconSize,
      height: iconSize,
      color: _color(context),
    );
  }
}
