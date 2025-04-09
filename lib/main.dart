import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signspeak/communication/communicator.dart';
import 'package:signspeak/tutorialapp.dart';
import 'package:signspeak/tutorialpage/tutorial.dart';
import 'firebase_options.dart';
import 'package:signspeak/dashboard/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signspeak/loginpage/login.dart';
import 'package:signspeak/translation/translatelang.dart';
import 'firebase_options.dart';
import 'package:signspeak/translation/signcam.dart'; 
import 'package:camera/camera.dart';      



List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); // Get the list of cameras
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Default route 
      routes: {
        '/login': (context) => const LoginPage(),
        '/app_usage_tutorial': (context) => const AppUsageTutorialPage(),
        '/home': (context) => const Homepage(),
        '/tutorial': (context) => const TutorialPage(),
        '/communication': (context) => SignAnimator(),
        '/translation': (context) => TranslateLang(),
        '/signcam': (context) => SignCam(camera: cameras.first), 
      },
    );
  }
}
