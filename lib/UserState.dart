import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Navigation.dart';
import 'Screens/Login_Screen.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data == null) {
            print('user don\'t have login yet');
            return LoginScreen();
          } else if (userSnapshot.hasData) {
            print('user is login');
            return App();
          } else if (userSnapshot.hasError) {
            const Center(
              child: Text(
                'An error has been occured',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                'Something occurred Wrong',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
