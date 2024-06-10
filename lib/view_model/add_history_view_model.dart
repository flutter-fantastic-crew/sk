import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sk/view_model/plan_view_model.dart';

import '../entity/plan_entity.dart';
import '../entity/plan_history_entity.dart';

class AddHistoryViewModel extends ChangeNotifier {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  late String _emojiIcon = _getRandomEmoji();
  bool _showPriceClearButton = false;
  bool _showContentClearButton = false;
  late PlanEntity _plan;
  DateTime _date = DateTime.now();

  AddHistoryViewModel(String planId) {
    _priceController.addListener(() => _onTextFieldChanged('price'));
    _contentController.addListener(() => _onTextFieldChanged('content'));

    _priceFocusNode.addListener(_onFocusChanged);
    _contentFocusNode.addListener(_onFocusChanged);
    getPlan(planId);
  }

  PlanEntity get plan => _plan;

  TextEditingController get priceController => _priceController;

  TextEditingController get contentController => _contentController;

  bool get showPriceClearButton => _showPriceClearButton;

  bool get showContentClearButton => _showContentClearButton;

  FocusNode get priceFocusNode => _priceFocusNode;

  FocusNode get contentFocusNode => _contentFocusNode;

  String get emojiIcon => _emojiIcon;

  DateTime get date => _date;

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

  void _onTextFieldChanged(String key) {
    if (key == 'price') {
      _showPriceClearButton = _priceController.text.isNotEmpty;
    } else if (key == 'content') {
      _showContentClearButton = _contentController.text.isNotEmpty;
    }
    notifyListeners();
  }

  void _onFocusChanged() {
    if (_priceFocusNode.hasFocus) {
      _showContentClearButton = false;
      _showPriceClearButton = _priceController.text.isNotEmpty;
    } else if (_contentFocusNode.hasFocus) {
      _showPriceClearButton = false;
      _showContentClearButton = _contentController.text.isNotEmpty;
    }
    notifyListeners();
  }

  void getPlan(String planId) {
    for (var plan in PlanViewModel().plans) {
      if (plan.id == int.parse(planId)) {
        _plan = plan;
        break;
      }
    }
  }

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

  void setPriceClearButton() {
    _showPriceClearButton = _priceController.text.isNotEmpty;
    notifyListeners();
  }

  void setContentClearButton() {
    _showPriceClearButton = _contentController.text.isNotEmpty;
    notifyListeners();
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

  // 일련번호 추출을 위한 임시 코드
  int getMaxId(List<PlanHistoryEntity> planHistories) {
    int maxId = 0;
    for (var entity in planHistories) {
      if (entity.id > maxId) {
        maxId = entity.id;
      }
    }
    return maxId;
  }

  PlanHistoryEntity get toPlanHistoryEntity {
    return PlanHistoryEntity(
        id: getMaxId(_plan.planHistory),
        type: PlanHistoryType.expense,
        amount: int.parse(_priceController.text.replaceAll(',', '')),
        memo: _contentController.text,
        createAt: _date);
  }
}
