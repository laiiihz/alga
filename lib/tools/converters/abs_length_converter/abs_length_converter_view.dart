import 'package:alga/constants/import_helper.dart';

part './abs_length_converter_provider.dart';

class AbsLengthConverterView extends StatelessWidget {
  const AbsLengthConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolView.scrollVertical(
      title: const Text('Absolute Length Converter'),
      children: LengthType.values.map((e) {
        return AppTitleWrapper(
          title: e.getName(context),
          child: Consumer(
            builder: (context, ref, _) {
              final currentController = ref.watch(_types(e));
              return TextField(
                controller: currentController,
                onChanged: (text) {
                  final double? currentValue =
                      text.isEmpty ? null : double.tryParse(text);
                  if (currentValue != null) {
                    final baseValue = e.getInch(currentValue);
                    for (var item in _restOfTypes(e)) {
                      ref.watch(_types(item)).text =
                          item.fromInch(baseValue).safeFixed(10);
                    }
                  } else {
                    for (var item in _restOfTypes(e)) {
                      ref.watch(_types(item)).text = '';
                    }
                  }
                },
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
