import 'package:alga/models/tool_items.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late NaviUtil _navi;

  @override
  void didChangeDependencies() {
    _navi = NaviUtil(context);
    ref.read(toolsProvider.notifier).state = _navi;
    ref.read(currentToolProvider.notifier).state = _navi.allToolsItem;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold();
  }
}
