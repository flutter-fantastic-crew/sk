import 'package:flutter/material.dart';

class PlanSummeryBottomSheet extends StatelessWidget {
  const PlanSummeryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          GestureDetector(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
          const Text('Bottom Sheet Content'),
        ],
      ),
    );
  }
}
