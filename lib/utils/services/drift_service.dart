import 'package:alga/models/alga_app_database.dart';
import 'package:alga/utils/constants/import_helper.dart';

final dbProvider = StateProvider.autoDispose((ref) => AlgaDB());
