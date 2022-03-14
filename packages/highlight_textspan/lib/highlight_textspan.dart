library highlight_textspan;

import 'package:flutter/material.dart';
import 'package:highlight/highlight.dart';

class HighlightTextSpan {
  final Map<String, TextStyle> theme;
  HighlightTextSpan(this.theme);

  TextSpan span(String data, String lang, TextStyle? defaultStyle) {
    if (lang == 'uri') {
      return TextSpan(style: defaultStyle, text: data);
      // return TextSpan(
      //   style: defaultStyle,
      //   children: uriHighlight(data),
      // );
    } else {
      return TextSpan(
        style: defaultStyle,
        children: _convert(highlight.parse(data, language: lang).nodes!),
      );
    }
  }

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className!]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans
            .add(TextSpan(children: tmp, style: theme[node.className!]));
        stack.add(currentSpans);
        currentSpans = tmp;

        for (var n in node.children!) {
          _traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        }
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }
}
