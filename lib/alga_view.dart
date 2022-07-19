import 'package:alga/constants/import_helper.dart';

class AlgaView extends StatefulWidget {
  const AlgaView({Key? key}) : super(key: key);

  @override
  State<AlgaView> createState() => _AlgaViewState();
}

class _AlgaViewState extends State<AlgaView> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            //TODO
            label: 'HOME',
          ),
          NavigationDestination(
            icon: const Icon(Icons.category_outlined),
            selectedIcon: const Icon(Icons.category_rounded),
            label: S.of(context).settings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings_rounded),
            label: S.of(context).settings,
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        selectedIndex: _index,
      ),
    );
  }
}
