import 'package:flutter/widgets.dart';

class AddPlanViewModel extends ChangeNotifier {
  late String _rangeText = '';

  String get rangeText => _rangeText;

  void setRangeText(String rangeText) {
    _rangeText = rangeText;
    notifyListeners();
  }
}
