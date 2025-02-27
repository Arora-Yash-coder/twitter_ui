import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_ui/models/user.dart';
import 'package:twitter_ui/screens/wrapper.dart';
import 'package:twitter_ui/services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.toString(),
            textDirection: TextDirection.ltr,
          ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            initialData: null,
            child: const MaterialApp(
              home: Wrapper(),
            ),
          );
        }
        return const Center(
            child: Text(
          "Loading",
          textDirection: TextDirection.ltr,
        ));
      },
    );
  }
}
