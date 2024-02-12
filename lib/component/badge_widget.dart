import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 뱃지 디자인이 상익님 말처럼 안되네요.... 컹..
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: const Text(
        '요약',
        style: TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}
