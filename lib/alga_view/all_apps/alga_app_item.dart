import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/app_atom.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';

class AlgaAppItem extends StatelessWidget {
  const AlgaAppItem(this.item, {super.key, this.listenable = true});
  final AppAtom item;
  final bool listenable;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;
    final secondColor = Theme.of(context).colorScheme.onSecondaryContainer;
    final background = Theme.of(context).colorScheme.primaryContainer;
    Widget iconButton() => IconButton(
          onPressed: () {
            FavoriteBox.update(item);
          },
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
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          GoRouter.of(context).go('/apps/${item.path}');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Material(
                    color: background,
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 44,
                      width: 44,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: item.icon,
                      ),
                      // child: item.,
                    ),
                  ),
                  const Spacer(),
                  listenableIconButton,
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: AutoSizeText(
                  item.title(context),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: secondColor,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
