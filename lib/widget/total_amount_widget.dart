import 'package:flutter/material.dart';

class TotalAmountWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final double marginLeft;
  final double marginRight;

  const TotalAmountWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.marginLeft,
    required this.marginRight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
            color: const Color(0xFFEAEAEA),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$amount 원',
              style: TextStyle(
                fontSize: 25,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
