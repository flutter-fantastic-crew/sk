import 'dart:math';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddHistoryPage extends StatefulWidget {
  const AddHistoryPage({super.key});

  @override
  State<AddHistoryPage> createState() => _AddHistoryPageState();
}

class _AddHistoryPageState extends State<AddHistoryPage> {
  late TextEditingController expenseController;
  late TextEditingController contentController;
  final FocusNode _focusNode = FocusNode();
  late String _emojiIcon;
  late DateTime _selectedDate;
  late bool _showClearButton = false;

  final List<String> _emojiList = [
    '😊',
    '🍵',
    '🌲',
    '💡',
  ];

  @override
  void initState() {
    super.initState();
    expenseController = TextEditingController();
    expenseController.addListener(_checkText);
    contentController = TextEditingController();
    _focusNode.requestFocus();
    _emojiIcon = _getRandomEmoji();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    // 컨트롤러들을 dispose 해주어야 메모리 누수를 방지할 수 있습니다.
    expenseController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _checkText() {
    setState(() {
      _showClearButton = expenseController.text.isNotEmpty;
    });
  }

  void _clearText() {
    expenseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 14,
          ),
          onPressed: () {
            _focusNode.unfocus();
            context.pop();
            // 바로가기 버튼이 눌렸을 때의 동작
          },
        ),
        title: const Column(
          children: [
            Text(
              '내역 추가', // 첫 번째 줄 텍스트
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '계획 제목', // 두 번째 줄 텍스트
              style: TextStyle(
                fontSize: 10,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double?>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffEEEEEE),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size?>(
                              const Size(60, 60))),
                      onPressed: () => {},
                      child: const Icon(
                        Icons.add,
                        color: Color(0XFF40BE40),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: expenseController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: '수입 금액',
                                    hintStyle: const TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                            if (_showClearButton)
                              InkWell(
                                onTap: _clearText,
                                child: const Icon(
                                  Icons.clear_rounded,
                                  size: 17,
                                  color: Colors.grey,
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              '원',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double?>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffEEEEEE),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size?>(
                            const Size(60, 60),
                          ),
                        ),
                        onPressed: _showEmojiPicker,
                        child: Text(
                          _emojiIcon,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '내용',
                            hintStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _showDatePicker,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double?>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffEEEEEE),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size?>(
                            const Size(60, 60),
                          ),
                        ),
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black38,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('MM월 dd일 EEE').format(_selectedDate),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            isToday(_selectedDate) ? '오늘' : '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Text(
                          '최근',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // 반경 설정
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(18),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // 버튼 모양과 일치시키기 위해 중복 설정
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF3D83F0),
                      ),
                    ),
                    child: const Text(
                      '저장',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmojiPicker(
          onEmojiSelected: (Category? category, Emoji? emoji) {
            if (emoji != null) {
              setState(() {
                _emojiIcon = emoji.emoji;
              });
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

  bool isToday(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return true;
    }
    return false;
  }

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _getRandomEmoji() {
    final random = Random();
    return _emojiList[random.nextInt(_emojiList.length)];
  }
}
