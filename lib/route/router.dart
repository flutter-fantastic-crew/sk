import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sk/page/add_history_page.dart';
import 'package:sk/page/home_page.dart';
import '../page/add_plan_step1_page.dart';
import '../page/add_plan_step2_page.dart';
import '../page/add_plan_step3_page.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'plan/:id/addHistory',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CupertinoPage(
              child: AddHistoryPage(
                planId: state.pathParameters['id']!,
              ),
            );
          },
        ),
        GoRoute(
          path: 'addPlan/step1',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const CupertinoPage(
              child: AddPlanStep1Page(),
            );
          },
        ),
        GoRoute(
          path: 'addPlan/step2',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const CupertinoPage(
              child: AddPlanStep2Page(),
            );
          },
        ),
        GoRoute(
          path: 'addPlan/step3',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const CupertinoPage(
              child: AddPlanStep3Page(),
            );
          },
        ),
      ],
    ),
  ],
);
