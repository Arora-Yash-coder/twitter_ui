import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_ui/services/user.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  UserService userService = UserService();
  File? profileImage;
  File? bannerImage;
  final picker = ImagePicker();
  String name = '';

  Future getImage(int type) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null && type == 0) {
        profileImage = File(pickedFile.path);
      }
      if (pickedFile != null && type == 1) {
        bannerImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await userService.updateProfile(bannerImage, profileImage, name);
              Navigator.pop(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Form(
              child: Column(
            children: [
              TextButton(
                onPressed: () {
                  getImage(0);
                },
                child: profileImage == null
                    ? const Icon(Icons.person)
                    : Image.file(
                        profileImage!,
                        height: 100,
                      ),
              ),
              TextButton(
                onPressed: () {
                  getImage(1);
                },
                child: bannerImage == null
                    ? const Icon(Icons.home)
                    : Image.file(
                        bannerImage!,
                        height: 100,
                      ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ],
          ))),
    );
  }
}
