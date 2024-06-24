import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/add_plan_view_model.dart';
import 'package:sk/widget/range_full_calendar_widget.dart';

class AddPlanStep1Page extends StatelessWidget {
  const AddPlanStep1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('###,###,###,###');
    return ChangeNotifierProvider<AddPlanViewModel>(
      create: (_) => AddPlanViewModel(),
      child: Builder(
        builder: (context) {
          if (context.read<AddPlanViewModel>().bottomSheetShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showBottomSheet(context, 'entry');
              context.read<AddPlanViewModel>().setBottomSheetShown(false);
            });
          }
          // 페이지 진입 시 바텀시트 노출
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '플랜 기간과 예산을',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '입력하세요',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          onTap: () => _showBottomSheet(context, 'click'),
                          child: const Row(
                            children: [
                              SizedBox(width: 20),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            context.watch<AddPlanViewModel>().startDay !=
                                    DateTime(1970, 1, 1)
                                ? "${DateFormat('MM월 dd일').format(context.read<AddPlanViewModel>().startDay!)} ~ ${DateFormat('MM월 dd일').format(context.read<AddPlanViewModel>().endDay!)}"
                                : '기간',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          context.read<AddPlanViewModel>().daysDifference !=
                                  null
                              ? "${context.read<AddPlanViewModel>().daysDifference}일"
                              : '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.sackDollar,
                          color: Colors.black38,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: context
                                .read<AddPlanViewModel>()
                                .budgetController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '예산',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              suffixText: '원',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                String formattedValue =
                                    numberFormat.format(int.parse(value));
                                context
                                        .read<AddPlanViewModel>()
                                        .budgetController
                                        .value =
                                    context
                                        .read<AddPlanViewModel>()
                                        .budgetController
                                        .value
                                        .copyWith(
                                          text: formattedValue,
                                          selection: TextSelection.collapsed(
                                              offset: formattedValue.length),
                                        );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                            context.push('/addPlan/step2');
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
                            '다음',
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
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String type) {
    Future.delayed(Duration(seconds: type == 'entry' ? 1 : 0), () {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return ChangeNotifierProvider.value(
                value: context.read<AddPlanViewModel>(),
                builder: (context, child) {
                  return RangeFullCalendarWidget(
                      firstDay: DateTime(
                          DateTime.now().year - 3, DateTime.now().month, 1),
                      lastDay: DateTime(
                          DateTime.now().year + 3, DateTime.now().month, 1));
                });
          });
    });
  }
}
