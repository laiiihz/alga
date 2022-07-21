import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/models/tool_atoms.dart';
import 'package:alga/models/tool_category.dart';
import 'package:alga/views/settings_view.dart';
import 'package:alga/widgets/placeholder_page.dart';

final rootIndex = StateProvider<int?>((ref) => null);
final categoryIndex = StateProvider<int?>((ref) => null);
final toolIndex = StateProvider<int?>((ref) => null);

final showCategory = StateProvider<bool>((ref) => ref.watch(rootIndex) == 1);
final showTools =
    StateProvider<bool>((ref) => ref.watch(categoryIndex) != null);

final enterCategory = StateProvider<bool>((ref) => false);
final enterTool = StateProvider<bool>((ref) => false);
final computedCategoryExpand =
    StateProvider.family<bool, AdaptiveWindowType>((ref, type) {
  if (type <= AdaptiveWindowType.small) return false;
  return ref.watch(enterCategory);
});
final computedToolExpand =
    StateProvider.family<bool, AdaptiveWindowType>((ref, type) {
  if (type <= AdaptiveWindowType.small) return false;
  return ref.watch(enterTool) || (!ref.watch(enterCategory));
});

final currentWidget = StateProvider<Widget>((ref) {
  final root = ref.watch(rootIndex);
  final category = ref.watch(categoryIndex);
  final tool = ref.watch(toolIndex);
  if (root == 0) {
    return const PlaceholderPage();
  } else if (root == 1) {
    if (category == null) {
      return const PlaceholderPage();
    } else {
      final current = getByCategory(ToolCategories.items[category]);
      if (tool == null) {
        return const PlaceholderPage();
      } else {
        return current[tool].widget;
      }
    }
  } else if (root == 2) {
    return const SettingsView();
  }

  return const PlaceholderPage();
});
