import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_ui/models/user.dart';
import 'package:twitter_ui/screens/auth/signup.dart';
import 'package:twitter_ui/screens/main/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      // Show Auth Routes
      return const SignUp();
    }
    // Show Main Routes
    return const Home();
  }
}
