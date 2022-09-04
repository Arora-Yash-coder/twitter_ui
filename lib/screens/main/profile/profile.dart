import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_ui/screens/main/posts/list.dart';
import 'package:twitter_ui/services/posts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService postService = PostService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: postService.getPostsByUser(FirebaseAuth.instance.currentUser?.uid),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(),
        body: const ListPosts(),
      ),
    );
  }
}
