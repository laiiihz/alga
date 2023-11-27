import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter_svg/svg.dart';

class AlgaLogo extends StatelessWidget {
  const AlgaLogo({
    super.key,
    this.radius = 48,
    this.padding = EdgeInsets.zero,
  });

  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: padding,
        child: SvgPicture.asset(
          'assets/logo/logo.svg',
          height: radius,
          width: radius,
          colorFilter:
              ColorFilter.mode(colorScheme.onBackground, BlendMode.srcIn),
        ),
      ),
    );
  }
}
