import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/product.dart';
import 'CartScreen.dart';
import 'FavoritScreen.dart';
import 'ProfileScreen.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  final user = FirebaseAuth.instance.currentUser;
  List<product_cls> product = [];
   bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Drawer(
        child: ListView(
          children: <Widget>[
            // header                   name of the person                          its mail
            UserAccountsDrawerHeader(
              accountName: const Text('Welcome'),
              accountEmail: Text(user!.email!),
              currentAccountPicture: GestureDetector(
                  child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )),
              decoration: const BoxDecoration(color: Colors.red),
            ),

            //  body


            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: const ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: const ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.deepPurple),
              ),
            ),


            InkWell(
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteScreen()),
              );},
              child: const ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const ListTile(
                title: Text('LOG OUT'),
                leading: Icon(Icons.logout),
              ),
            ),

            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Switch(
                    value: isDarkModeEnabled,
                    onChanged: (value) {
                      // Update the state when the switch is toggled
                      setState(() {
                        isDarkModeEnabled = value;
                      });
                    },
                  ),
                  Text(
                    isDarkModeEnabled ? 'Dark Mode' : 'Light Mode',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
