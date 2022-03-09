import 'package:alga/models/tool_items.dart';
import 'package:alga/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late NaviUtil _navi;
  @override
  void didChangeDependencies() {
    _navi = NaviUtil(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      tools: _navi.toolGroups,
      settingsItem: _navi.settingsItem,
      allToolsItem: _navi.allToolsItem,
    );
  }
}
