import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../view_model/add_history_view_model.dart';
import '../widget/select_full_calendar_widget.dart';

class AddHistoryPage extends StatelessWidget {
  final String planId;

  const AddHistoryPage({super.key, required this.planId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddHistoryViewModel>(
      create: (_) => AddHistoryViewModel(planId),
      builder: (context, child) {
        return Consumer<AddHistoryViewModel>(
            builder: (_, addHistoryViewModel, __) {
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
                  addHistoryViewModel.priceFocusNode.unfocus();
                  context.pop();
                  // 바로가기 버튼이 눌렸을 때의 동작
                },
              ),
              title: Column(
                children: [
                  Text(
                    addHistoryViewModel.plan.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    addHistoryViewModel.plan.memo,
                    style: const TextStyle(
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
                                elevation: WidgetStateProperty.all<double?>(0),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xffEEEEEE),
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all<Size?>(
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
                                      controller:
                                          addHistoryViewModel.priceController,
                                      focusNode:
                                          addHistoryViewModel.priceFocusNode,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: '수입 금액',
                                        hintStyle: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        suffixIcon: addHistoryViewModel
                                                .showPriceClearButton
                                            ? GestureDetector(
                                                onTap: () => {
                                                  addHistoryViewModel
                                                      .priceController
                                                      .clear()
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.black38,
                                                  size: 17,
                                                ),
                                              )
                                            : null,
                                      ),
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
                                elevation: WidgetStateProperty.all<double?>(0),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xffEEEEEE),
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all<Size?>(
                                  const Size(60, 60),
                                ),
                              ),
                              onPressed: () => showEmojiPicker(context),
                              child: Text(
                                addHistoryViewModel.emojiIcon,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller:
                                    addHistoryViewModel.contentController,
                                focusNode: addHistoryViewModel.contentFocusNode,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '내용',
                                  hintStyle: const TextStyle(fontSize: 18),
                                  suffixIcon:
                                      addHistoryViewModel.showContentClearButton
                                          ? GestureDetector(
                                              onTap: () => {
                                                addHistoryViewModel
                                                    .contentController
                                                    .clear()
                                              },
                                              child: const Icon(
                                                Icons.cancel,
                                                color: Colors.black38,
                                                size: 17,
                                              ),
                                            )
                                          : null,
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
                            GestureDetector(
                              onTap: () => showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return ChangeNotifierProvider.value(
                                        value:
                                            context.read<AddHistoryViewModel>(),
                                        builder: (context, child) {
                                          return SelectFullCalendarWidget(
                                              firstDay: DateTime(
                                                  DateTime.now().year - 3,
                                                  DateTime.now().month,
                                                  1),
                                              lastDay: DateTime(
                                                  DateTime.now().year + 3,
                                                  DateTime.now().month,
                                                  0),
                                              now: context
                                                  .read<AddHistoryViewModel>()
                                                  .date);
                                        });
                                  }),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 15),
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat('MM월 dd일 EEE')
                                  .format(addHistoryViewModel.date),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  addHistoryViewModel.isToday() ? '오늘' : '',
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
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54),
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
                          onPressed: () {
                            context.pop(context
                                .read<AddHistoryViewModel>()
                                .toPlanHistoryEntity);
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(18),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // 버튼 모양과 일치시키기 위해 중복 설정
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFF3D83F0),
                            ),
                          ),
                          child: const Text(
                            '저장',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
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
        });
      },
    );
  }

  void showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmojiPicker(
          onEmojiSelected: (Category? category, Emoji? emoji) {
            if (emoji != null) {
              context
                  .read<AddHistoryViewModel>()
                  .setEmoji(emoji.emoji.toString());
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
}
