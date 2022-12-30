import 'package:alga/alga_view/widgets/alga_panel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlgaPanel extends ConsumerStatefulWidget {
  const AlgaPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlgaPanelState();
}

class _AlgaPanelState extends ConsumerState<AlgaPanel> {
  @override
  Widget build(BuildContext context) {
    Widget result = Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // safe area
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset('assets/logo/256.webp', height: 32, width: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Alga',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(4),
              children: const [
                AlgaPanelItem(
                  icon: Icon(Icons.category_outlined),
                  activeIcon: Icon(Icons.category),
                  title: Text('应用'),
                  path: '/apps',
                ),
                AlgaPanelItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  title: Text('设置'),
                  path: '/settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
    result = SizedBox(width: 120, child: result);

    return result;
  }
}
