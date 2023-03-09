import 'package:alga/ui/alga_view/widgets/alga_panel_item.dart';
import 'package:alga/utils/constants/import_helper.dart';

class AlgaPanel extends ConsumerStatefulWidget {
  const AlgaPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlgaPanelState();
}

class _AlgaPanelState extends ConsumerState<AlgaPanel> {
  @override
  Widget build(BuildContext context) {
    Widget result = Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // safe area
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset('assets/logo/256.webp', height: 32, width: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Alga',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(4),
              children: [
                AlgaPanelItem(
                  icon: const Icon(Icons.category_outlined),
                  activeIcon: const Icon(Icons.category),
                  title: Text(context.tr.allApps),
                  path: '/apps',
                ),
                AlgaPanelItem(
                  icon: const Icon(Icons.favorite_outline_rounded),
                  activeIcon: const Icon(Icons.favorite_rounded),
                  title: Text(context.tr.favorite),
                  path: '/favorite',
                ),
                AlgaPanelItem(
                  icon: const Icon(Icons.search_outlined),
                  activeIcon: const Icon(Icons.search_rounded),
                  title: Text(context.tr.search),
                  path: '/search',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: AlgaPanelItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              title: Text(context.tr.settings),
              path: '/settings',
            ),
          ),
        ],
      ),
    );
    result = SizedBox(width: 132, child: result);

    return result;
  }
}
