import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sk/entity/plan_entity.dart';
import 'package:sk/view_model/plan_view_model.dart';
import 'package:sk/widget/app_bar_widget.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('###,###,###,###'); // 나라를 지정하는 방법.
    return ChangeNotifierProvider<PlanViewModel>(
        create: (_) => PlanViewModel(),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFF3F3F3),
            appBar: AppBarWidget(context: context),
            body: SafeArea(
              child: Column(
                children: [
                  Consumer<PlanViewModel>(
                    // 데이터 변조가 일어나면 새로 랜더링 됨
                    builder: (_, planViewModel, __) {
                      return Expanded(
                        // 겉을 감싸고 있는(현재 영역) 부분의 최대치
                        child: PageView.builder(
                          onPageChanged: planViewModel.changePage,
                          controller: planViewModel.pageController,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(50),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        planViewModel.plans[index].icon,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        planViewModel.plans[index].name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 130.0,
                                          lineWidth: 2.0,
                                          percent: planViewModel.plans[index]
                                              .getLeftDatePercent(),
                                          backgroundColor:
                                              const Color(0XFFEEEEEE),
                                          progressColor: Colors.black87,
                                          center: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Transform.translate(
                                                offset: Offset(
                                                  (130 *
                                                      math.cos(2 *
                                                              math.pi *
                                                              planViewModel
                                                                  .plans[index]
                                                                  .getLeftDatePercent() -
                                                          math.pi /
                                                              2)), // X 좌표 계산
                                                  (130 *
                                                      math.sin(2 *
                                                              math.pi *
                                                              planViewModel
                                                                  .plans[index]
                                                                  .getLeftDatePercent() -
                                                          math.pi /
                                                              2)), // Y 좌표 계산
                                                ),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.access_time_filled,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        planViewModel.plans[index].type ==
                                                PlanType.set
                                            ? CircularPercentIndicator(
                                                radius: 120.0,
                                                lineWidth: 12.0,
                                                percent: 0.1,
                                                backgroundColor:
                                                    const Color(0XffEEEEEE),
                                                progressColor: Colors.blue,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                // center:
                                              )
                                            : const SizedBox(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              '남은 예산',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${numberFormat.format(planViewModel.plans[index].totalExpenses)}원',
                                                  style: const TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                const Icon(
                                                  CupertinoIcons
                                                      .chevron_compact_right,
                                                  size: 18,
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              '/ ${numberFormat.format(planViewModel.plans[index].totalAmount)}원',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10), // 반경 설정
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.go('/addHistory');
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          const EdgeInsets.all(15),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // 버튼 모양과 일치시키기 위해 중복 설정
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color(0xFF3D83F0),
                                        ),
                                      ),
                                      child: const Text(
                                        '내역 추가',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: planViewModel.plans.length,
                        ),
                      );
                    },
                  ),
                  Container(
                    // stack으로 구현하는 케이스도 있음. 컨슈머에 포함되면 watch를 사용할 수는 있지만 두번 바인딩됨.
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // 감싸고 있는 위젯의 세로 정방향 (cross는 가로 정방향)
                      children: List<Widget>.generate(
                        context
                            .watch<PlanViewModel>()
                            .plans
                            .length, // 변경을 감지하여 바인딩된 데이터를 감지하여 ui 변경
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor:
                                context.watch<PlanViewModel>().currentPage ==
                                        index
                                    ? const Color(0xFF181818)
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
