import 'package:alga/constants/import_helper.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(title: const Text('搜索')),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchPersistentHeader(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(0, 56),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.search_rounded),
                      label: Text(context.tr.search),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverGrid(delegate: delegate, gridDelegate: gridDelegate),
        ],
      ),
    );
  }
}

class _SearchPersistentHeader extends SliverPersistentHeaderDelegate {
  const _SearchPersistentHeader({required this.child});

  final Widget child;
  static const double _kHeight = 84;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(width: double.infinity, height: _kHeight, child: child);
  }

  @override
  double get maxExtent => _kHeight;

  @override
  double get minExtent => _kHeight;

  @override
  bool shouldRebuild(_SearchPersistentHeader oldDelegate) =>
      child != oldDelegate.child;
}
