import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/FavoritScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/ProfileScreen.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  int indexValue = 0;
  List<Widget> pages = [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[700],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexValue,
        onTap: (index) {
          setState(() {
            indexValue = index;
          });
        },
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.amber[900]),
        selectedItemColor: Colors.amber[900],
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "favorite", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
        ],
      ),
      body: pages[indexValue],
    );
  }
}
