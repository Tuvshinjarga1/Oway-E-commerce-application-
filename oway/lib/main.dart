import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oway/home.dart';
import 'package:oway/phone_otp_ui/phone.dart';
import 'package:oway/phone_otp_ui/verify.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCeKQDpM26-BlTStCTFCZi8QHE9kJenIxA",
      appId: "AIzaSyCeKQDpM26-BlTStCTFCZi8QHE9kJenIxA",
      messagingSenderId: "AIzaSyCeKQDpM26-BlTStCTFCZi8QHE9kJenIxA",
      projectId: "oway-cc924",
    ),
  );
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'home': (context) => HomePage(),
    },
  ));
}