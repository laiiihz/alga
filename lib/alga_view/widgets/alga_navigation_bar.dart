import 'package:alga/constants/import_helper.dart';
import 'package:go_router/go_router.dart';

class AlgaNavigationBar extends StatefulWidget {
  const AlgaNavigationBar({super.key});

  @override
  State<AlgaNavigationBar> createState() => _AlgaNavigationBarState();
}

class _AlgaNavigationBarState extends State<AlgaNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int getIndex() {
      final location = GoRouter.of(context).location;
      if (location.startsWith('/apps')) return 0;
      if (location.startsWith('/favorite')) return 1;
      if (location.startsWith('/search')) return 2;
      if (location.startsWith('/settings')) return 3;
      return 0;
    }

    return NavigationBar(
      selectedIndex: getIndex(),
      onDestinationSelected: (value) {
        String path = '/apps';
        switch (value) {
          case 0:
            path = '/apps';
            break;
          case 1:
            path = '/favorite';
            break;
          case 2:
            path = '/search';
            break;
          case 3:
            path = '/settings';
            break;
        }
        GoRouter.of(context).go(path);
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.category_outlined),
          selectedIcon: const Icon(Icons.category_rounded),
          label: context.tr.allApps,
        ),
        NavigationDestination(
          icon: const Icon(Icons.favorite_outline_rounded),
          selectedIcon: const Icon(Icons.favorite_rounded),
          label: context.tr.favorite,
        ),
        NavigationDestination(
          icon: const Icon(Icons.search_outlined),
          selectedIcon: const Icon(Icons.search_rounded),
          label: context.tr.search,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: context.tr.settings,
        ),
      ],
    );
  }
}
