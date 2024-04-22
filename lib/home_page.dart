import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/plan_view_model.dart';
import 'package:sk/widget/app_bar_widget.dart';

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
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
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
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () => {}, child:
                                          const Text(
                                            '내역추가'
                                          )),
                                        ],
                                      )
                                    ],
                                  )
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
