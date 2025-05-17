import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/screens/home_page.dart';
import 'package:practicing_firebase_authentication/services/auth_service.dart';
import 'package:practicing_firebase_authentication/services/network_client.dart';
import 'package:practicing_firebase_authentication/widgets/snackbar.dart';

class VerificationEmailScreen extends StatefulWidget {
  const VerificationEmailScreen({super.key});

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificationEmailScreenState();
}

class _VerificationEmailScreenState extends State<VerificationEmailScreen> {
  Timer? _emailCheckTimer;

  bool _isEmailVerified = false;

  @override
  void initState() {
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (_isEmailVerified == false) {
      _sendVerificationEmail();
    }
    _timer();
    super.initState();
  }

  @override
  void dispose() {
    _emailCheckTimer?.cancel();
    super.dispose();
  }

  void _timer() {
    print('inside timer');
    _emailCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _isVerified();
    });
  }

  Future<void> _isVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (_isEmailVerified == true) {
      _emailCheckTimer?.cancel();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            spacing: 10,
            children: [
              Flexible(
                child: Text('A verification link will sent to your Email'),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _onTapButton,
                label: Text("Resend link"),
                icon: Icon(Icons.email),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapButton() async {
    _sendVerificationEmail();
  }

  Future<void> _sendVerificationEmail() async {
    final NetworkClient response = await AuthService.verifyEmail();
    if (response.isSuccess) {
    } else {
      showBottomSnackbar(
        message: response.errorMessage,
        context: context,
        isError: true,
      );
    }
  }
}
