// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alga/utils/constants/import_helper.dart';

class ScrollableScaffold extends StatelessWidget {
  const ScrollableScaffold({
    super.key,
    required this.title,
    this.configurations = const [],
  });

  final Widget title;
  final List<Widget> configurations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(title: title),
          if (configurations.isNotEmpty)
            SliverList.builder(
              itemBuilder: (context, index) {
                return configurations[index];
              },
              itemCount: configurations.length,
            ),
        ],
      ),
    );
  }
}
