import 'package:alga/utils/constants/import_helper.dart';
import 'package:go_router/go_router.dart';

class AlgaPanelItem extends StatelessWidget {
  const AlgaPanelItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.path,
  });
  final Widget icon;
  final Widget activeIcon;
  final Widget title;
  final String path;

  @override
  Widget build(BuildContext context) {
    final bool active = GoRouter.of(context).location.startsWith(path);
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () {
        GoRouter.of(context).go(path);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            AnimatedContainer(
              duration: kThemeAnimationDuration,
              curve: Curves.easeInOutCubic,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(active ? 1 : 0),
                borderRadius: active
                    ? BorderRadius.circular(8)
                    : BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: IconTheme(
                  data: IconThemeData(
                    color: active
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  child: active ? activeIcon : icon,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                      color:
                          active ? Theme.of(context).colorScheme.primary : null,
                    ),
                child: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
