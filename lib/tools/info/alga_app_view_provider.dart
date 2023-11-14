import 'package:alga/models/app_category.dart';
import 'package:alga/utils/constants/import_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alga_app_view_provider.g.dart';

@riverpod
TabController appTabController(AppTabControllerRef ref,
    {required TickerProvider vsync}) {
  return TabController(
    length: AppCategory.items.length + 1,
    vsync: vsync,
  );
}
