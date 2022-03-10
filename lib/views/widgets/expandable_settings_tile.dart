import 'package:alga/constants/import_helper.dart';
import 'package:alga/views/widgets/settings_tile.dart';

class ExpandableSettingsTile extends StatefulWidget {
  final Widget title;
  final Widget leading;
  final Widget child;
  const ExpandableSettingsTile({
    Key? key,
    required this.title,
    required this.leading,
    required this.child,
  }) : super(key: key);

  @override
  State<ExpandableSettingsTile> createState() => _ExpandableSettingsTileState();
}

class _ExpandableSettingsTileState extends State<ExpandableSettingsTile> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expand = !_expand;
            });
          },
          child: SettingsTile(
            leading: widget.leading,
            title: widget.title,
            trailing: AnimatedRotation(
              turns: _expand ? 0.5 : 0,
              duration: const Duration(milliseconds: 400),
              child: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
          child: AnimatedAlign(
            alignment: Alignment.topLeft,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            heightFactor: _expand ? 1 : 0,
            child: Material(
              color: isDark(context) ? Colors.grey[150] : Colors.grey[30],
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}
