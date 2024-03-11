import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/plan_view_model.dart';
import 'package:sk/widget/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBarWidget(context),
      body: SafeArea(
        child: ChangeNotifierProvider<PlanViewModel>(
          create: (_) => PlanViewModel(),
          builder: (context, child) {
            return Column(
              children: [
                Consumer<PlanViewModel>( // 데이터 변조가 일어나면 새로 랜더링 됨
                  builder: (_, planViewModel, __) {
                    return Expanded( // 겉을 감싸고 있는(현재 영역) 부분의 최대치
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
                                      Text(planViewModel.plans[index].icon),
                                      Text(planViewModel.plans[index].name),
                                    ],
                                  ),
                                ],
                              ));
                        },
                        itemCount: planViewModel.plans.length,
                      ),
                    );
                  },
                ),
                Container( // stack으로 구현하는 케이스도 있음. 컨슈머에 포함되면 watch를 사용할 수 없음.
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 감싸고 있는 위젯의 세로 정방향 (cross는 가로 정방향)
                    children: List<Widget>.generate(
                        context.watch<PlanViewModel>().plans.length, // 변경을 감지하여 바인딩된 데이터를 감지하여 ui 변경
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: context
                                            .watch<PlanViewModel>()
                                            .currentPage ==
                                        index
                                    ? const Color(0xFF181818)
                                    : Colors.grey,
                              ),
                            )),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
