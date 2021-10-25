import 'package:flutter/material.dart';

import 'home.dart';
import 'fooder_lich_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData theme = FooderlichTheme.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fooder Lich',
      theme: theme,
      home: const Home(),
    );
  }
}
