import 'package:flutter/material.dart';
import 'package:twitter_ui/screens/home/feed.dart';
import 'package:twitter_ui/screens/home/search.dart';
import 'package:twitter_ui/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = AuthService();
  int currentIndex = 0;

  final List<Widget> children = [
    const Feed(),
    const Search(),
  ];

  void onTabPressed(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: children[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('ThatBoi'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('SignOut'),
              onTap: () async {
                authService.signOut();
              },
            ),
            ListTile(
              title: const Text('Edit'),
              onTap: () async {
                Navigator.pushNamed(context, '/edit');
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabPressed,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        ],
      ),
    );
  }
}
