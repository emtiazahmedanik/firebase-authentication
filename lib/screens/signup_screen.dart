import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/screens/home_page.dart';
import 'package:practicing_firebase_authentication/screens/login_screen.dart';
import 'package:practicing_firebase_authentication/screens/verification_email_screen.dart';
import 'package:practicing_firebase_authentication/services/auth_service.dart';
import 'package:practicing_firebase_authentication/services/network_client.dart';
import 'package:practicing_firebase_authentication/widgets/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [Text("SignUp"), Text("Create Account")]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text("Email"),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }
                  return null;
                },
              ),
              Text("Password"),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  } else if (value.length < 6) {
                    return "Enter at least 6 digit password";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _onTapSignupButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text("sign up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (predicate) => false,
                  );
                },
                child: Text("LogIn"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSignupButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    print('call from signup');
    final NetworkClient response = await AuthService.createAccount(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationEmailScreen()),
      );
    } else {
      showBottomSnackbar(
        message: response.errorMessage,
        context: context,
        isError: true,
      );
    }
  }
}
