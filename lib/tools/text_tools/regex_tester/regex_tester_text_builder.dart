import 'package:flutter/material.dart';

// class RegexTesterTextBuilder extends SpecialTextSpanBuilder {
//   RegexTesterTextBuilder(
//     this.reg, {
//     required this.primaryColor,
//     required this.onPrimary,
//   });
//   final RegExp? reg;
//   final Color primaryColor;
//   final Color onPrimary;
//   @override
//   TextSpan build(String data,
//       {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
//     if (data.isEmpty) return const TextSpan(text: '');
//     if (reg == null) return TextSpan(text: data, style: textStyle);

//     final spans = <InlineSpan>[];

//     int currentIndex = 0;
//     Match? currentMatch = reg!.matchAsPrefix(data, currentIndex);
//     while (currentIndex < data.length) {
//       if (currentMatch != null) {
//         if (currentMatch.start == currentMatch.end) {
//           currentIndex++;
//         } else {
//           final tempText = data.substring(
//             currentMatch.start,
//             currentMatch.end,
//           );
//           spans.add(TextSpan(
//             text: tempText,
//             style: TextStyle(
//               color: onPrimary,
//               backgroundColor: primaryColor,
//             ),
//           ));
//           currentIndex += currentMatch.end - currentMatch.start;
//         }
//       } else {
//         spans.add(TextSpan(text: data[currentIndex]));
//         currentIndex++;
//       }
//       currentMatch = reg!.matchAsPrefix(data, currentIndex);
//     }
//     spans.add(TextSpan(text: data.substring(currentIndex)));

//     return TextSpan(children: spans, style: textStyle);
//   }

//   @override
//   SpecialText? createSpecialText(String flag,
//       {TextStyle? textStyle,
//       SpecialTextGestureTapCallback? onTap,
//       required int index}) {
//     return null;
//   }
// }
