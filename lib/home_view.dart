import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/hotkey_util.dart';
import 'package:alga/widgets/app_scaffold.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _navi = NaviUtil();

  @override
  void initState() {
    super.initState();
    if (mounted) ref.read(toolsProvider.notifier).state = _navi;
    if (mounted) {
      ref.read(currentToolProvider.notifier).state = _navi.allToolsItem;
    }
    HotkeyUtil.init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold();
  }
}
