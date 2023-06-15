import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'common/widgets/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'this page does\'t exist'),
        ),
      );
  }
}
