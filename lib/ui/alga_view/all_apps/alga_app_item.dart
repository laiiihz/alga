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
    return ValueListenableBuilder(
      valueListenable: FavoriteBox.listener(item.path),
      builder: (context, _, child) {
        final state = FavoriteBox.get(item);
        return Material(
          color: colorScheme.secondaryContainer,
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: item.icon,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AutoSizeText(
                    item.title(context),
                    maxLines: 2,
                    minFontSize: 12,
                    style: TextStyle(
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
