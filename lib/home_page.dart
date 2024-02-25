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
      appBar: AppBarWidget(),
      body: SafeArea(
        child: ChangeNotifierProvider<PlanViewModel>(
          create: (_) => PlanViewModel(),
          builder: (context, child) {
            return Column(
              children: [
                Consumer<PlanViewModel>(
                  builder: (_, planViewModel, __) {
                    return Expanded(
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
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        context.watch<PlanViewModel>().plans.length,
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
