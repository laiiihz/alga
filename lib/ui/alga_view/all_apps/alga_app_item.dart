import 'package:alga/models/app_atom.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AlgaAppItem extends StatelessWidget {
  const AlgaAppItem(this.item, {super.key, this.listenable = true});
  final AppAtom item;
  final bool listenable;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color iconColor = colorScheme.tertiary;

    return ValueListenableBuilder(
      valueListenable: FavoriteBox.listener(item.path),
      builder: (context, _, child) {
        final state = FavoriteBox.get(item);
        return Material(
          color: colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: state
                ? BorderSide(color: colorScheme.primary, width: 2)
                : BorderSide.none,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              GoRouter.of(context).go(item.path);
            },
            onLongPress: () {
              FavoriteBox.update(item);
            },
            child: child,
          ),
        );
      },
      child: Stack(
        children: [
          Positioned(
            left: 16 - 48,
            bottom: 16,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconTheme.merge(
                data: IconThemeData(
                  size: 84,
                  color: iconColor.withOpacity(0.4),
                ),
                child: item.icon,
              ),
            ),
          ),
          Positioned(
            left: 48,
            right: 16,
            top: 8,
            bottom: 16,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: AutoSizeText(
                  item.title(context),
                  maxLines: 2,
                  minFontSize: 12,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: colorScheme.onSecondaryContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
