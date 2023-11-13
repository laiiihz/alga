import 'package:alga/utils/constants/import_helper.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/logo/256.webp', height: 64, width: 64),
    );
  }
}
