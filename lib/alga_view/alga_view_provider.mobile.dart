import 'package:alga/alga_view/alga_all_tool_view.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/views/settings_view.dart';
import 'package:alga/widgets/placeholder_page.dart';

final rootIndex = StateProvider<int>((ref) => 0);

final currentWidget = StateProvider<Widget>((ref) {
  final index = ref.watch(rootIndex);
  switch (index) {
    case 0:
      return const AlgaAllToolView();
    case 1:
      return const SettingsView();
    default:
      return const PlaceholderPage();
  }
});
