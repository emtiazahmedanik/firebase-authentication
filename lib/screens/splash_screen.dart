import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/screens/home_page.dart';
import 'package:practicing_firebase_authentication/screens/login_screen.dart';
import 'package:practicing_firebase_authentication/screens/signup_screen.dart';
import 'package:practicing_firebase_authentication/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    AuthService.firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}
