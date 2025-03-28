import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signspeak/communication/communicator.dart';
import 'firebase_options.dart';
import 'package:signspeak/dashboard/homepage.dart';
import 'package:signspeak/loginpage/login.dart';
import 'package:signspeak/loginpage/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
    home: SignAnimator()
    );
  }
}
