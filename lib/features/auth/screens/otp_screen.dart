
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);
 
@override
State<OTPScreen> createState() =>  _OTPScreenState();

}
  @override
  class _OTPScreenState extends State<OTPScreen>{
  Widget build(BuildContext context) {
   

    return Scaffold();
  }
  
  }

