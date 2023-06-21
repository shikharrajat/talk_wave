import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
             SizedBox(height: size.height/12),
            Text('Verifying your number',style: Theme.of(context)
                  .textTheme
                  .titleLarge!.copyWith(fontWeight: FontWeight.w600,fontSize: 30)
                  ,),
                  SizedBox(height: size.height/20),
            Text('We have sent an SMS with a code.',style: Theme.of(context)
                  .textTheme
                  .titleMedium!),
            SizedBox(height: size.height/7),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration:  InputDecoration(
                  hintText: '_ _ _ _ _ _',
                  hintStyle:  Theme.of(context)
                  .textTheme.titleMedium!
                  
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                      verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    
    
    