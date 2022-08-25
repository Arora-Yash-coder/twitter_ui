import 'package:flutter/material.dart';
import 'package:twitter_ui/services/posts.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final PostService postService = PostService();
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tweet'),
        actions: [
          FlatButton(
            onPressed: () async {
              postService.savePost(text);
              Navigator.pop(context);
            },
            child: const Text(
              'Tweet',
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Form(
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                text = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
