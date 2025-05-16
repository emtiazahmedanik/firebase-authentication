
import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/screens/home_page.dart';
import 'package:practicing_firebase_authentication/screens/signup_screen.dart';
import 'package:practicing_firebase_authentication/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashScreen(),
    );
  }
}