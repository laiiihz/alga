import 'package:alga/l10n/l10n.dart';
import 'package:alga/ui/alga_view/all_apps/alga_app_item.dart';
import 'package:alga/ui/widgets/asset_svg.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoriteRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoriteView();
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: Text(context.tr.favorite)),
          if (FavoriteBox.items.isEmpty)
            const SliverToBoxAdapter(
              child: AssetSvg('assets/images/house.svg'),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: ValueListenableBuilder(
              valueListenable: FavoriteBox.listenerAll,
              builder: (context, _, __) {
                final items = FavoriteBox.items;
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return AlgaAppItem(item);
                    },
                    childCount: items.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 1.618,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
