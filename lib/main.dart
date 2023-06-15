import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/mobilescreenlayout.dart';
import './colors.dart';
import 'package:talk_wave/firebase_options.dart';
import 'screens/webscreenlayout.dart';
import './responsive/responsive_layout.dart';
import 'features/landing/screens/landing_screen.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          appBarTheme: const AppBarTheme(color: appBarColor),
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: const LandingScreen());
  }
}
