import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: 360,
            //   height: 25,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(5),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.3),
            //         spreadRadius: 1,
            //         blurRadius: 10,
            //         offset: Offset(0,1),
            //       ),
            //     ],
            //   ),
            //   child: Center(
            //     child: Text(
            //       'Personal Info',
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),

            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/guest.png'),
            ),
            SizedBox(height: 20),
            Text(
              user!.email!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action for settings button
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action for language button
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              child: Text(
                'Language',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
