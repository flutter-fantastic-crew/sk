import 'package:flutter/widgets.dart';

class AddPlanViewModel extends ChangeNotifier {
  DateTime? _startDay = DateTime(1970, 1, 1);
  DateTime? _endDay = DateTime(1970, 1, 1);
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _bottomSheetShown = true;

  DateTime? get startDay => _startDay;

  DateTime? get endDay => _endDay;

  TextEditingController get budgetController => _budgetController;

  TextEditingController get nameController => _nameController;

  TextEditingController get descriptionController => _descriptionController;

  bool get bottomSheetShown => _bottomSheetShown;

  @override
  void dispose() {
    _budgetController.dispose();
    _nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void setStartDay(DateTime? startDay) {
    _startDay = startDay;
    notifyListeners();
  }

  void setEndDay(DateTime? endDay) {
    _endDay = endDay;
    notifyListeners();
  }

  void setBottomSheetShown(bool bottomSheetShown) {
    _bottomSheetShown = bottomSheetShown;
    notifyListeners();
  }

  int? get daysDifference {
    if (_endDay != null && _startDay != null) {
      int difference = _endDay!.difference(_startDay!).inDays;
      return difference > 0 ? difference : null;
    }
    return null;
  }
}
