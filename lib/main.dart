import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signspeak/communication/communicator.dart';
import 'package:signspeak/tutorialpage/tutorial.dart';
import 'firebase_options.dart';
import 'package:signspeak/dashboard/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signspeak/loginpage/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, 
    
    initialRoute: '/login',
  routes: {
    '/login': (context) => const LoginPage(),
    '/home': (context) => const Homepage(),
    '/tutorial': (context) => const TutorialPage(),
    '/communication': (context) =>  SignAnimator(),
  },
    
    home: LoginPage());
  }
}
