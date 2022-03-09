import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final String svg;
  final bool colorIcon;
  const SvgAssetIcon(this.svg, {Key? key, this.colorIcon = false})
      : super(key: key);

  Color? _color(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (colorIcon) return null;
    return brightness == Brightness.dark ? Colors.white70 : Colors.black87;
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
