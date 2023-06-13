import 'package:flutter/material.dart';
import 'screens/mobilescreenlayout.dart';
import './colors.dart';
import 'screens/webscreenlayout.dart';
import './responsive/responsive_layout.dart';

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
        ),
        home: const ResponsiveLayout(
            mobileScreenLayout: MobileLayoutScreen(),
            webScreenLayout: WebLayoutScreen()));
  }
}
