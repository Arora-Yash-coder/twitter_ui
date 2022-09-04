import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_ui/models/user.dart';
import 'package:twitter_ui/screens/main/posts/list.dart';
import 'package:twitter_ui/services/posts.dart';
import 'package:twitter_ui/services/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService postService = PostService();
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: postService
              .getPostsByUser(FirebaseAuth.instance.currentUser?.uid),
          initialData: null,
        ),
        StreamProvider.value(
          value:
              userService.getUserInfo(FirebaseAuth.instance.currentUser?.uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      Provider.of<UserModel>(context).bannerImageUrl ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  Provider.of<UserModel>(context)
                                          .profileImageUrl ??
                                      '',
                                  fit: BoxFit.cover,
                                  height: 60,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/edit');
                                  },
                                  child: const Text('Edit Profile'),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  Provider.of<UserModel>(context).name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ];
            },
            body: const ListPosts(),
          ),
        ),
      ),
    );
  }
}
