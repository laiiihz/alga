import 'package:alga/alga_view/all_apps/alga_app_item.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';
import 'package:alga/widgets/asset_svg.dart';

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
                    maxCrossAxisExtent: 200,
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
