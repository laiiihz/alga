import 'package:alga/routers/app_router.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:alga/utils/constants/import_helper.dart';

class AlgaNavigationBar extends StatefulWidget {
  const AlgaNavigationBar({super.key});

  @override
  State<AlgaNavigationBar> createState() => _AlgaNavigationBarState();
}

class _AlgaNavigationBarState extends State<AlgaNavigationBar> {
  int getIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppsRoute().location)) return 0;
    if (location.startsWith(FavoriteRoute().location)) return 1;
    if (location.startsWith(SearchRoute().location)) return 0;
    if (location.startsWith(SettingsRoute().location)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: getIndex(context),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            AppsRoute().go(context);
          case 1:
            FavoriteRoute().go(context);
          case 2:
            SettingsRoute().go(context);
          default:
        }
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
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: context.tr.settings,
        ),
      ],
    );
  }
}
