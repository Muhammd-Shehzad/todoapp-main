import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/UI/Home/home_screen.dart';
import 'package:todoapp/UI/auth/SignUp/sign_up.dart';

class SplashService {
  void isLogIn(context) {
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth auth = FirebaseAuth.instance;

      final user = auth.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      }
    });
  }
}
