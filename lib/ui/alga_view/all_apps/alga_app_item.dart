import 'package:alga/l10n/l10n.dart';
import 'package:alga/models/app_atom.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlgaAppItem extends StatelessWidget {
  const AlgaAppItem(this.item,
      {super.key, this.listenable = true, this.useGrid = true});
  final AppAtom item;
  final bool listenable;
  final bool useGrid;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color iconColor = colorScheme.primary;
    if (useGrid) {
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
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                GoRouter.of(context).go(item.path);
              },
              onSecondaryTapUp: (detail) {
                _showMenu(context, detail.localPosition, state);
              },
              onLongPress: () {
                _showMenuModal(context, state);
              },
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconTheme.merge(
                  data: IconThemeData(
                    size: 48,
                    color: iconColor.withOpacity(0.4),
                  ),
                  child: item.icon,
                ),
              ),
            ),
            Positioned(
              left: 56,
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
    } else {
      return ValueListenableBuilder(
          valueListenable: FavoriteBox.listener(item.path),
          builder: (context, _, __) {
            final state = FavoriteBox.get(item);
            return GestureDetector(
              onSecondaryTapUp: (detail) {
                _showMenu(context, detail.localPosition, state);
              },
              child: ListTile(
                leading: item.icon,
                title: Text(item.title(context)),
                onTap: () {
                  GoRouter.of(context).go(item.path);
                },
                selected: state,
                onLongPress: () {
                  _showMenuModal(context, state);
                },
              ),
            );
          });
    }
  }

  _showMenu(BuildContext context, Offset offset, bool like) async {
    final widget = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        widget.localToGlobal(offset, ancestor: overlay),
        widget.localToGlobal(widget.size.topLeft(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final colorScheme = Theme.of(context).colorScheme;
    final state = await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              like
                  ? Text(
                      context.tr.removeFavorite,
                      style: TextStyle(color: colorScheme.error),
                    )
                  : Text(context.tr.addFavorite),
              const Spacer(),
              like
                  ? Icon(Icons.delete_rounded, color: colorScheme.error)
                  : Icon(Icons.favorite_rounded, color: colorScheme.tertiary),
            ],
          ),
        ),
      ],
    );
    if (!context.mounted) return;

    switch (state) {
      case 0:
        FavoriteBox.update(item);
      default:
    }
  }

  _showMenuModal(BuildContext context, bool like) async {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: false,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: like
                    ? Text(
                        context.tr.removeFavorite,
                        style: TextStyle(color: colorScheme.error),
                      )
                    : Text(context.tr.addFavorite),
                trailing: like
                    ? Icon(Icons.delete_rounded, color: colorScheme.error)
                    : Icon(Icons.favorite_rounded, color: colorScheme.tertiary),
                onTap: () {
                  FavoriteBox.update(item);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
