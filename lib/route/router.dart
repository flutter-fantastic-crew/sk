import 'package:go_router/go_router.dart';
import 'package:sk/page/add_history_page.dart';
import 'package:sk/page/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
        path: '/addHistory',
        builder: (context, state) => const AddHistoryPage()),
  ],
);
