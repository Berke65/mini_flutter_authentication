import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled2/pages/auth/home_page.dart';
import 'package:untitled2/pages/auth/sign_up.dart';
import 'firebase_options.dart';
import 'package:untitled2/pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delirecem',
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: const LoginPage(),
      ),
      routes: {
       "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage(),
      },
    );
  }
}