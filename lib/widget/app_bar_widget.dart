import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sk/widget/plan_summary_bottom_sheet.dart';
import '../view_model/plan_view_model.dart';
import 'badge_widget.dart';

class AppBarWidget extends AppBar {
  BuildContext context;
  AppBarWidget({required this.context, super.key})
      : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: GestureDetector(
            onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                builder: (_) {
                  return ChangeNotifierProvider.value(
                      value: context.read<PlanViewModel>(),
                      builder: (context, child) {
                        return const PlanSummeryBottomSheet();
                      });
                }),
            child: const Row(
              children: [
                Text(
                  '내 플랜',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: BadgeWidget(text: '요약'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black38,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black38,
              ),
              onPressed: () {},
            ),
          ],
        );
}
