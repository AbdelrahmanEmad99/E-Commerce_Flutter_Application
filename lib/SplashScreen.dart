import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'UserState.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delayed navigation to the next screen after 4 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserState()),
      );
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/images/animation_lm4hmixs.json',
          width: double.infinity,
          height: double.infinity,
          repeat: false,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
