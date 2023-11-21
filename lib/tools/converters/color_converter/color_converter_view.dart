import 'package:alga/tools/converters/color_converter/color_converter.dart';
import 'package:alga/utils/constants/import_helper.dart';

class ColorConverterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ColorConverterView();
  }
}

class ColorConverterView extends StatelessWidget {
  const ColorConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorConverterPage();
  }
}
