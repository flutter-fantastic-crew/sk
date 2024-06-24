import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/add_plan_view_model.dart';

class AddPlanStep3Page extends StatelessWidget {
  const AddPlanStep3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPlanViewModel>(
      create: (_) => AddPlanViewModel(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
            ),
            body: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      '마지막 페이지 ${context.read<AddPlanViewModel>().startDay}'
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
