import 'package:alga/constants/import_helper.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/logo/256.webp', height: 64, width: 64),
    );
  }
}
