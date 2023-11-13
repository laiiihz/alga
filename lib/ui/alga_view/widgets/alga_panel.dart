import 'package:alga/routers/app_router.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/search_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:alga/ui/widgets/alga_logo.dart';
import 'package:alga/utils/constants/import_helper.dart';

class AlgaPanel extends ConsumerStatefulWidget {
  const AlgaPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlgaPanelState();
}

class _AlgaPanelState extends ConsumerState<AlgaPanel> {
  @override
  Widget build(BuildContext context) {
    Widget result = NavigationRail(
      leading: const Padding(
        padding: EdgeInsets.only(top: 32),
        child: AlgaLogo(),
      ),
      labelType: NavigationRailLabelType.selected,
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.category_outlined),
          selectedIcon: const Icon(Icons.category_rounded),
          label: Text(context.tr.allApps),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.favorite_outline_rounded),
          selectedIcon: const Icon(Icons.favorite_rounded),
          label: Text(context.tr.favorite),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.search_outlined),
          selectedIcon: const Icon(Icons.search_rounded),
          label: Text(context.tr.search),
        ),
      ],
      trailing:
          GoRouterState.of(context).matchedLocation == SettingsRoute().location
              ? IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded),
                )
              : IconButton(
                  onPressed: () {
                    SettingsRoute().go(context);
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
      selectedIndex: getIndex(context),
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            AppsRoute().go(context);
          case 1:
            FavoriteRoute().go(context);
          case 2:
            SearchRoute().go(context);
          default:
        }
      },
    );

    return result;
  }

  int? getIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppsRoute().location)) return 0;
    if (location.startsWith(FavoriteRoute().location)) return 1;
    if (location.startsWith(SearchRoute().location)) return 2;
    if (location.startsWith(SettingsRoute().location)) return null;
    return null;
  }
}
