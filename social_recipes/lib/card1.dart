import 'package:flutter/material.dart';

import 'fooder_lich_theme.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Stack(
        children: [
          Text(
            category,
            style: FooderlichTheme.darkTextTheme.bodyText1,
          ),
          Positioned(
            child: Text(
              title,
              style: FooderlichTheme.darkTextTheme.headline5,
            ),
            top: 20,
          ),
          Positioned(
            child: Text(
              description,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            bottom: 30,
            right: 0,
          ),
          Positioned(
            child: Text(
              chef,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            bottom: 10,
            right: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints.expand(
        width: 350,
        height: 450,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/mag1.png'),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
