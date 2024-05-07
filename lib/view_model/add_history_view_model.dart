import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHistoryViewModel extends ChangeNotifier {
  late TextEditingController expenseController;
  late TextEditingController contentController;
  late FocusNode focusNode = FocusNode();
  late String emojiIcon;
  late bool showClearButton = false;
  late final DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  // final PlanHistoryEntity _planHistory = PlanHistoryEntity(
  //   id: 1,
  //   type: PlanHistoryType.expense,
  //   amount: 2000,
  //   memo: '부득 부득이한 지출',
  //   createAt: DateTime.now(),
  // );

  final List<String> _emojiList = [
    '😊',
    '🍵',
    '🌲',
    '💡',
  ];

  AddHistoryViewModel() {
    expenseController = TextEditingController();
    expenseController.addListener(_checkText);
    contentController = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    emojiIcon = _getRandomEmoji();
    _selectedDate = DateTime.now();
    showClearButton = false;
  }

  @override
  void dispose() {
    expenseController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _checkText() {
    showClearButton = expenseController.text.isNotEmpty;
    notifyListeners();
  }

  void clearText() {
    expenseController.clear();
    notifyListeners();
  }

  String getFormattedDate() {
    return DateFormat('MM월 dd일 EEE').format(selectedDate);
  }

  bool isToday() {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  Future showDatePickers(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((DateTime? pickedDate) {
      if (pickedDate != null && pickedDate != _selectedDate) {
        _selectedDate = pickedDate;
        notifyListeners(); // 변경 알림을 여기서 호출합니다.
      }
    });
  }

  Future showEmojiPicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmojiPicker(
          onEmojiSelected: (Category? category, Emoji? emoji) {
            if (emoji != null) {
              emojiIcon = emoji.emoji;
              notifyListeners();
            }
            Navigator.pop(context);
          },
          config: const Config(
            columns: 7,
            emojiSizeMax: 32.0,
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            recentsLimit: 28,
            categoryIcons: CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
          ),
        );
      },
    );
  }

  String _getRandomEmoji() {
    final random = Random();
    return _emojiList[random.nextInt(_emojiList.length)];
  }
}
