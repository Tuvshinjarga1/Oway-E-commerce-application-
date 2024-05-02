import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oway/UndsenNuur/home.dart';
import 'package:oway/firebase_options.dart';
import 'package:oway/phone_otp_ui/phone.dart';
import 'package:oway/phone_otp_ui/verify.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    initialRoute: 'home',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'home': (context) => HomePage(userId: '',),
    },
  ));
}