import 'package:flutter/material.dart';

import 'badge_widget.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key})
      : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
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
