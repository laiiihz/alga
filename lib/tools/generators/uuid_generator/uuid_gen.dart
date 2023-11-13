import 'package:alga/ui/widgets/scaffold/scrollable_scaffold.dart';
import 'package:alga/utils/constants/import_helper.dart';

class UUIDGenPage extends StatefulWidget {
  const UUIDGenPage({super.key});

  @override
  State<UUIDGenPage> createState() => _UUIDGenPageState();
}

class _UUIDGenPageState extends State<UUIDGenPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      title: Text(context.tr.generatorUUID),
    );
  }
}
