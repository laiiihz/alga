import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final String svg;
  final bool colorIcon;
  const SvgAssetIcon(this.svg, {super.key, this.colorIcon = false});

  Color? _color(BuildContext context) {
    if (colorIcon) return null;
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size;
    final iconColor = IconTheme.of(context).color;
    final color = _color(context);
    final svgWidget = SvgPicture.asset(
      svg,
      width: iconSize,
      height: iconSize,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(iconColor ?? color, BlendMode.srcIn),
    );
    return SizedBox.square(
      dimension: iconSize,
      child:
          color == null ? Opacity(opacity: 0.4, child: svgWidget) : svgWidget,
    );
  }
}
