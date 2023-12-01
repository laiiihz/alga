import 'package:alga/l10n/l10n.dart';
import 'package:alga/routers/app_router.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_view.dart';
import 'package:alga/ui/views/favorite_view.dart';
import 'package:alga/ui/views/settings_view.dart';
import 'package:alga/ui/widgets/alga_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings_rounded),
          label: Text(context.tr.settings),
        ),
      ],
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
    );

    return result;
  }

  int? getIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppsRoute().location)) return 0;
    if (location.startsWith(FavoriteRoute().location)) return 1;
    if (location.startsWith(SettingsRoute().location)) return 2;
    return null;
  }
}
