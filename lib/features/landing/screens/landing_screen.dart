import 'package:flutter/material.dart';
import 'package:talk_wave/features/auth/screens/login_screen.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            const Spacer(flex: 3),
            Text(
              "Welcome to TalkWave",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 33),
            ),
            SizedBox(height: size.height / 9),
            Text(
              'Read our Privacy Policy. Tap "Agree and continue" \nto accept the Terms of Service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall!.color!,
              ),
            ),
            const Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () => navigateToLoginScreen(context),
                  child: Row(
                    children: [
                      Text(
                        "Agree and Continue",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Theme.of(context).textTheme.titleMedium!.color!,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: size.height / 9),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.8),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
} 
    