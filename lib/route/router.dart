import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sk/page/add_history_page.dart';
import 'package:sk/page/home_page.dart';

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
          }
        )
      ],
    ),
  ],
);
