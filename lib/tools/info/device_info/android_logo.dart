import 'package:alga/tools/info/device_info/device_info.provider.dart';
import 'package:alga/ui/widgets/svg_asset_icon.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:flutter_svg/svg.dart';

class AndroidLogo extends ConsumerWidget {
  const AndroidLogo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(androidInfoProvider).whenOrNull(data: (data) {
          final asset = _assetMap[data.version.sdkInt];
          if (asset == null) return null;
          return IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(asset),
                    ),
                  );
                },
              );
            },
            icon: SvgAssetIcon(asset, colorIcon: true),
          );
        }) ??
        const SizedBox.shrink();
  }
}

const _assetMap = <int, String>{
  21: 'assets/android/lollipop.svg',
  22: 'assets/android/lollipop.svg',
  23: 'assets/android/marshmallow.svg',
  24: 'assets/android/nougat.svg',
  25: 'assets/android/nougat.svg',
  26: 'assets/android/oreo.svg',
  27: 'assets/android/oreo_dark.svg',
  28: 'assets/android/p.svg',
  29: 'assets/android/q.svg',
  30: 'assets/android/a11.svg',
  31: 'assets/android/a12.svg',
  32: 'assets/android/a12.svg',
  33: 'assets/android/a13.svg',
  34: 'assets/android/a14.svg',
};
