import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class RangeFullCalendarWidgetViewModel extends ChangeNotifier {
  DateTime? _rangeStartDay;
  DateTime? _rangeEndDay;
  String _rangeText = '';

  DateTime? get rangeStartDay => _rangeStartDay;

  DateTime? get rangeEndDay => _rangeEndDay;

  String get rangeText => _rangeText;

  void setRangeStartDay(DateTime rangeStartDay) {
    _rangeStartDay = rangeStartDay;
    notifyListeners();
  }

  void setRangeEndDay(DateTime rangeEndDay) {
    _rangeEndDay = rangeEndDay;
    notifyListeners();
  }

  void setRangeText(DateTime? startDay, DateTime? endDay) {
    if (startDay != null && endDay != null) {
      _rangeText =
          '${DateFormat('M월 d일').format(startDay)} ~ ${DateFormat('M월 d일').format(endDay)}';
    }
    notifyListeners();
  }
}
