import 'package:alga/main.dart';
import 'package:alga/models/tool_items.dart';
import 'package:alga/utils/hotkey_util.dart';
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
  void initState() {
    super.initState();
    _navi = NaviUtil(globalContext);
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
