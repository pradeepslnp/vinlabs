import 'package:demo_app/features/app/splash_screen/splash_screen.dart';
import 'package:demo_app/features/user_auth/presentation/screens/home/home_page.dart';
import 'package:demo_app/features/user_auth/presentation/screens/login_page.dart';
import 'package:demo_app/features/user_auth/presentation/screens/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDtsez4ZeuAwaDn20coJq7ca14OkmiSuUw",
          authDomain: "vinnovatelabz-49ef3.firebaseapp.com",
          projectId: "vinnovatelabz-49ef3",
          storageBucket: "vinnovatelabz-49ef3.appspot.com",
          messagingSenderId: "843688380008",
          appId: "1:843688380008:web:786ab23f242b926ad6dddd",
          measurementId: "G-M7W1KYRFZK"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => const SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
