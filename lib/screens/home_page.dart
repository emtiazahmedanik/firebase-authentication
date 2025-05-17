import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/screens/login_screen.dart';
import 'package:practicing_firebase_authentication/services/auth_service.dart';
import 'package:practicing_firebase_authentication/services/network_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [IconButton(onPressed: _onTapSignOut, icon: Icon(Icons.exit_to_app))],
      ),
    );
  }

  void _onTapSignOut() async {
    NetworkClient response = await AuthService.signOut();
    if (response.isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (predicate) => false,
      );
    }
  }
}
