import 'package:alga/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class DateFormatHelper extends StatelessWidget {
  const DateFormatHelper({super.key});

  static show(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        title: Text(context.tr.formatTable),
        content: const DateFormatHelper(),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(context.mtr.okButtonLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 512,
      width: 600,
      child: TableView.builder(
        columnCount: 4,
        rowCount: FormatData.values.length,
        pinnedColumnCount: 1,
        pinnedRowCount: 1,
        columnBuilder: (index) {
          const lengths = <double>[64, 240, 128, 128];
          return TableSpan(extent: FixedTableSpanExtent(lengths[index]));
        },
        rowBuilder: (index) {
          return const TableSpan(extent: FixedTableSpanExtent(32));
        },
        cellBuilder: (context, v) {
          final item = FormatData.values[v.row];
          switch (v.column) {
            case 0:
              return Text(item.symbol);
            case 1:
              return Text(item.meaning);
            case 2:
              return Text(item.presentation);
            case 3:
              return Text(item.example);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class FormatData {
  final String symbol;
  final String meaning;
  final String presentation;
  final String example;
  const FormatData(this.symbol, this.meaning, this.presentation, this.example);

  static const values = <FormatData>[
    FormatData('Symbol', 'Meaning', 'Presentation', 'Example'),
    FormatData('G', 'era designator', 'Text', 'AD'),
    FormatData('y', 'year', 'Number', '1996'),
    FormatData('M', 'month in year', 'Text & Number', 'July & 07'),
    FormatData('L', 'standalone month', 'Text & Number', 'July & 07'),
    FormatData('d', 'day in month', 'Number', '10'),
    FormatData('c', 'standalone day', 'Number', '10'),
    FormatData('h', 'hour in am/pm (1~12)', 'Number', '12'),
    FormatData('H', 'hour in day (0~23)', 'Number', '0'),
    FormatData('m', 'minute in hour', 'Number', '30'),
    FormatData('s', 'second in minute', 'Number', '55'),
    FormatData('S', 'fractional second', 'Number', '978'),
    FormatData('E', 'day of week', 'Text', 'Tuesday'),
    FormatData('D', 'day in year', 'Number', '189'),
    FormatData('a', 'am/pm marker', 'Text', 'PM'),
    FormatData('k', 'hour in day (1~24)', 'Number', '24'),
    FormatData('K', 'hour in am/pm (0~11)', 'Number', '0'),
    FormatData('Q', 'quarter', 'Text', 'Q3'),
    FormatData("'", 'escape for text', 'Delimiter', "'Date='"),
    FormatData("''", 'single quote', 'Literal', "'o''clock'")
  ];
}
