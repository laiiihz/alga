import 'package:alga/alga_view/alga_view.desktop.dart';
import 'package:alga/alga_view/alga_view.mobile.dart';
import 'package:alga/constants/import_helper.dart';
import 'package:alga/utils/window_util.dart';

class AlgaView extends StatelessWidget {
  const AlgaView({super.key});

  @override
  Widget build(BuildContext context) {
    if (WindowUtil.isMobileDevice) {
      return const AlgaViewMobile();
    } else {
      return const AlgaViewDesktop();
    }
  }
}
