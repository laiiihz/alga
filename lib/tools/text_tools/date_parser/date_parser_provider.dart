import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateParserProvider extends ChangeNotifier {
  final inputController = TextEditingController();
  final formatController = TextEditingController();

  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? state) {
    _date = state;
    notifyListeners();
  }

  String _formatText = '';
  String get formatText => _formatText;
  set formatText(String state) {
    _formatText = state;
    notifyListeners();
  }

  update() {
    date = DateTime.tryParse(inputController.text);
  }

  format() {
    if (date == null) return;
    formatText = DateFormat(formatController.text).format(date!);
  }

  showSupportedDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Supported Date Format'),
        );
      },
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    formatController.dispose();
    super.dispose();
  }
}
