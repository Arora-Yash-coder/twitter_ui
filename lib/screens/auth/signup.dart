import 'package:flutter/material.dart';
import 'package:twitter_ui/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //
  final AuthService _authService = AuthService();

  // User Details
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: const Text('SignUP'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => setState(() {
                  email = value;
                }),
              ),
              TextFormField(
                onChanged: (value) => setState(() {
                  password = value;
                }),
              ),
              MaterialButton(
                onPressed: () async {
                  _authService.signIn(email, password);
                },
                child: const Text('SignUP'),
              ),
              MaterialButton(
                onPressed: () async {
                  _authService.signUp(email, password);
                },
                child: const Text('SignIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
