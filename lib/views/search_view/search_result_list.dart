import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/widgets/app_scaffold.dart';

class SearchResultList extends ConsumerStatefulWidget {
  const SearchResultList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultListState();
}

class _SearchResultListState extends ConsumerState<SearchResultList> {
  @override
  Widget build(BuildContext context) {
    final allItems = ref.watch(toolsProvider).items;
    final currentItem = ref.read(currentToolProvider.notifier);
    return ListView.builder(
      itemBuilder: (context, index) {
        final tool = allItems[index];
        return ListTile(
          title: tool.title(context),
          leading: tool.icon,
          onTap: () {
            currentItem.state = tool;
            Navigator.pop(context);
          },
        );
      },
      itemCount: allItems.length,
    );
  }
}
