import 'package:flutter/material.dart';
import './colors.dart';

void main() {
  runApp(const TalkWave());
}

class TalkWave extends StatelessWidget {
  const TalkWave({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TalkWave',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ));
  }
}
