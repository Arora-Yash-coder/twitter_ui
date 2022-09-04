import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_ui/models/user.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? userFormFirebaseUser(User? user) {
    return user != null ? UserModel(id: user.uid) : null;
  }

  Stream<UserModel?> get user {
    return auth.authStateChanges().map(userFormFirebaseUser);
  }

  Future signUp(email, password) async {
    try {
      UserCredential user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user?.uid)
          .set({'name': email, 'email': email});
      userFormFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password) async {
    try {
      UserCredential user = (await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
      userFormFirebaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
