// refer to https://github.com/petitparser/dart-petitparser-examples

import 'package:petitparser/petitparser.dart';

class PyDictGrammar extends GrammarDefinition {
  @override
  Parser start() => ref0(value).end();

  Parser token(Object source, [String? name]) {
    if (source is String) {
      return source.toParser().trim();
    } else if (source is Parser) {
      ArgumentError.checkNotNull(name, 'name');
      return source.flatten('Expected $name').trim();
    } else {
      throw ArgumentError('Unknown token type: $source.');
    }
  }

  Parser array() =>
      ref1(token, '[') & ref0(elements).optional() & ref1(token, ']');
  Parser tuple() =>
      ref1(token, '(') & ref0(elements).optional() & ref1(token, ')');
  Parser elements() => ref0(value).plusSeparated(ref1(token, ','));
  Parser members() => ref0(pair).plusSeparated(ref1(token, ','));
  Parser object() =>
      ref1(token, '{') & ref0(members).optional() & ref1(token, '}');
  Parser pair() => ref0(stringToken) & ref1(token, ':') & ref0(value);
  Parser value() => [
        ref0(stringToken),
        ref0(numberToken),
        ref0(object),
        ref0(array),
        ref0(tuple),
        ref0(trueToken),
        ref0(falseToken),
        ref0(nullToken),
      ].toChoiceParser(failureJoiner: selectFarthestJoined);

  Parser trueToken() => ref1(token, 'true');
  Parser falseToken() => ref1(token, 'false');
  Parser nullToken() => ref1(token, 'null');
  Parser stringToken() => ref2(token, ref0(stringPrimitive), 'string');
  Parser numberToken() => ref2(token, ref0(numberPrimitive), 'number');

  Parser characterPrimitive() =>
      ref0(characterNormal) | ref0(characterEscape) | ref0(characterUnicode);
  Parser characterNormal() => pattern('^"\\|^\'\\');
  Parser characterEscape() => char('\\') & pattern(jsonEscapeChars.keys.join());
  Parser characterUnicode() => string('\\u') & pattern('0-9A-Fa-f').times(4);
  Parser numberPrimitive() =>
      char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();
  Parser stringPrimitive() =>
      pattern('"|\'') & ref0(characterPrimitive).star() & pattern('"|\'');
}

const Map<String, String> jsonEscapeChars = {
  '\\': '\\',
  '/': '/',
  '"': '"',
  '\'': '\'',
  'b': '\b',
  'f': '\f',
  'n': '\n',
  'r': '\r',
  't': '\t'
};
