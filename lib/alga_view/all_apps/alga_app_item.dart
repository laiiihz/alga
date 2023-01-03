import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/app_atom.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:alga/widgets/custom_icon_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';

class AlgaAppItem extends StatelessWidget {
  const AlgaAppItem(this.item, {super.key, this.listenable = true});
  final AppAtom item;
  final bool listenable;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;
    final background = Theme.of(context).colorScheme.primaryContainer;
    Widget iconButton() => CustomIconButton(
          onPressed: () {
            FavoriteBox.update(item);
          },
          tooltip: context.tr.favorite,
          icon: Icon(
            FavoriteBox.get(item)
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        );
    Widget listenableIconButton = iconButton();
    if (listenable) {
      listenableIconButton = ValueListenableBuilder(
        valueListenable: FavoriteBox.listener(item.path),
        builder: (context, value, child) {
          return iconButton();
        },
      );
    }
    return Material(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          GoRouter.of(context).go('/apps/${item.path}');
        },
        child: Stack(
          children: [
            Positioned(
              left: 4,
              top: 4,
              child: Material(
                color: background,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 56,
                  width: 56,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: item.icon,
                  ),
                  // child: item.,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: listenableIconButton,
            ),
            const SizedBox(height: 8),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: AutoSizeText(
                item.title(context),
                maxLines: 1,
                minFontSize: 12,
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
