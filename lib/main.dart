import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sk/view_model/plan_view_model.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlanViewModel>(
      create: (_) => PlanViewModel(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
