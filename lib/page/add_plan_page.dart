import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/add_plan_view_model.dart';
import 'package:sk/widget/range_full_calendar_widget.dart';

class AddPlanPage extends StatelessWidget {
  const AddPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          context.watch<AddPlanViewModel>().rangeText.isNotEmpty
                              ? context.read<AddPlanViewModel>().rangeText
                              : '기간',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                    child: const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.sackDollar,
                          color: Colors.black38,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '예산',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                              suffixText: '원',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
