import 'package:alga/constants/import_helper.dart';

class AnimatedShowWidget extends StatelessWidget {
  final bool isShow;
  final Widget? child;
  const AnimatedShowWidget(
      {Key? key, required this.isShow, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isShow ? 1 : 0,
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 250),
      child: AnimatedAlign(
        alignment: Alignment.centerLeft,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 250),
        widthFactor: isShow ? 1 : 0,
        child: child,
      ),
    );
  }
}
