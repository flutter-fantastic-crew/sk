import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/plan_history_entity.dart';

class AddHistoryViewModel extends ChangeNotifier {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();
  late String _emojiIcon = _getRandomEmoji();
  bool _showClearButton = false;
  DateTime _date = DateTime.now();

  AddHistoryViewModel(planId);

  TextEditingController get priceController => _priceController;

  TextEditingController get contentController => _contentController;

  FocusNode get priceFocusNode => _priceFocusNode;

  String get emojiIcon => _emojiIcon;

  bool get showClearButton => _showClearButton;

  DateTime get date => _date;

  final PlanHistoryEntity _planHistory = PlanHistoryEntity(
    id: 1,
    type: PlanHistoryType.expense,
    amount: 2000,
    memo: '부득 부득이한 지출',
    createAt: DateTime.now(),
  );

  final List<String> _emojiList = [
    '😊',
    '🍵',
    '🌲',
    '💡',
  ];

  @override
  void dispose() {
    _priceController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // void _checkText() {
  //   _showClearButton = _expenseController.text.isNotEmpty;
  //   notifyListeners();
  // }

  void clearText() {
    _priceController.clear();
    notifyListeners();
  }

  String getFormattedDate(selectedDate) {
    return DateFormat('MM월 dd일 EEE').format(selectedDate);
  }

  bool isToday() {
    final now = DateTime.now();
    return _date.year == now.year &&
        _date.month == now.month &&
        _date.day == now.day;
  }

  void setEmoji(String emojiIcon) {
    _emojiIcon = emojiIcon;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  String _getRandomEmoji() {
    final random = Random();
    return _emojiList[random.nextInt(_emojiList.length)];
  }

  PlanHistoryEntity get toPlanHistoryEntity {
    return PlanHistoryEntity(
        id: 200,
        type: PlanHistoryType.expense,
        amount: int.parse(_priceController.text.replaceAll(',', '')),
        memo: _contentController.text,
        createAt: _date);
  }
}
