import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final String svg;
  final bool colorIcon;
  const SvgAssetIcon(this.svg, {Key? key, this.colorIcon = false})
      : super(key: key);

  Color? _color(BuildContext context) {
    if (colorIcon) return null;
    return Theme.of(context).colorScheme.secondary;
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
