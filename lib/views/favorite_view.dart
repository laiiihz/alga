import 'package:alga/alga_view/all_apps/alga_app_item.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/hive_boxes/favorite_box.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: Text(context.tr.favorite)),
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
                    maxCrossAxisExtent: 240,
                    childAspectRatio: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
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
