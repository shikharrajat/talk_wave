import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/common/utils/utils.dart';
import '/features/auth/controller/auth_controller.dart';


class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
       
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [  SizedBox(height: size.height/12)
              ,Text('Enter your phone number',style: Theme.of(context)
                  .textTheme
                  .titleLarge!.copyWith(fontWeight: FontWeight.w600,fontSize: 30)
                  ,),
                SizedBox(height: size.height/20),
               Text('TalkWave will need to verify your phone number.',style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  ,),
               SizedBox(height: size.height/12 ),
              TextButton(
                onPressed: pickCountry,
                child:  Text('Pick Country',style: Theme.of(context)
                  .textTheme
                  .titleMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 20)
                 ),
              ),
               SizedBox(height: size.height/25 ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      style: Theme.of(context)
                  .textTheme
                  .bodyMedium!,
                      decoration:  InputDecoration(
                        hintText: 'phone number',
                        hintStyle:  Theme.of(context)
                  .textTheme.titleMedium
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.4),
               FittedBox(
                child: TextButton(
                    onPressed: sendPhoneNumber,
                    child: Row(
                      children: [
                        Text(
                          "Next",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color!,fontWeight: FontWeight.w500,fontSize: 25
                              ),
                        ),
                         SizedBox(height: size.height / 9),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!,
                              
                        )
                      ],
                    )
                    ),
              ),
              
            
            ],
          ),
        ),
      ),
    );
  }
}