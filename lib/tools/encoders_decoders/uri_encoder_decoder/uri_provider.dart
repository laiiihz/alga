part of './uri_encoder_decoder.dart';

enum UriEncodeType {
  full,
  component,
  queryComponent,
  ;

  String getName(BuildContext context) {
    switch (this) {
      case UriEncodeType.full:
        return S.of(context).uriTypeFull;
      case UriEncodeType.component:
        return S.of(context).uriTypeComponent;
      case UriEncodeType.queryComponent:
        return S.of(context).uriTypeQueryComponent;
    }
  }
}

/// decoded
final _input = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final _inputText = Provider.autoDispose((ref) => ref.watch(_input).text);

final _isEncode = StateProvider.autoDispose<bool>((ref) => true);

final _type =
    StateProvider.autoDispose<UriEncodeType>((ref) => UriEncodeType.component);

final _result = Provider.autoDispose<String>((ref) {
  final isEncode = ref.watch(_isEncode);
  final text = ref.watch(_inputText);
  if (text.isEmpty) return '';
  switch (ref.watch(_type)) {
    case UriEncodeType.full:
      return isEncode ? Uri.encodeFull(text) : Uri.decodeFull(text);
    case UriEncodeType.component:
      return isEncode ? Uri.encodeComponent(text) : Uri.decodeComponent(text);
    case UriEncodeType.queryComponent:
      return isEncode
          ? Uri.encodeQueryComponent(text)
          : Uri.decodeQueryComponent(text);
  }
});
