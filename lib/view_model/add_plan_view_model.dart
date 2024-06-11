import 'package:flutter/widgets.dart';

class AddPlanViewModel extends ChangeNotifier {
  late String _rangeText = '';
  bool _bottomSheetShown = true;

  String get rangeText => _rangeText;
  bool get bottomSheetShown => _bottomSheetShown;

  void setRangeText(String rangeText) {
    _rangeText = rangeText;
    notifyListeners();
  }

  void setBottomSheetShown(bool bottomSheetShown) {
    _bottomSheetShown = bottomSheetShown;
    notifyListeners();
  }
}
