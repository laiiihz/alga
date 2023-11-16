import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssetSvg extends StatelessWidget {
  const AssetSvg(this.path, {super.key});

  final String path;

  @override
  Widget build(BuildContext context) {
    Widget result = SvgPicture.asset(
      path,
      theme: SvgTheme(
        currentColor: Theme.of(context).colorScheme.primary,
      ),
    );

    result = Padding(padding: const EdgeInsets.all(32), child: result);
    result = ConstrainedBox(
      constraints: BoxConstraints.loose(const Size.square(384)),
      child: result,
    );
    return result;
  }
}

//  currentcolor
