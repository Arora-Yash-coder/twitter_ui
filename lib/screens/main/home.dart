import 'package:flutter/material.dart';
import 'package:twitter_ui/services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home Page'),
          MaterialButton(
            child: const Text('SignOut'),
            onPressed: () {
              authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
