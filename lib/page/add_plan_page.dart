import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/add_plan_view_model.dart';
import 'package:sk/widget/range_full_calendar_widget.dart';

class AddPlanPage extends StatelessWidget {
  const AddPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });

    return ChangeNotifierProvider<AddPlanViewModel>(
      create: (_) => AddPlanViewModel(),
      builder: (context, child) {
        return Consumer<AddPlanViewModel>(builder: (_, addPlanViewModel, __) {
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
                          onTap: () => _showBottomSheet(context),
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
                          addPlanViewModel.rangeText.isNotEmpty
                              ? addPlanViewModel.rangeText
                              : '기간',
                          style: TextStyle(
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
        });
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return RangeFullCalendarWidget(
                firstDay:
                    DateTime(DateTime.now().year - 3, DateTime.now().month, 1),
                lastDay:
                    DateTime(DateTime.now().year + 3, DateTime.now().month, 1));
          });
    });
  }
}
