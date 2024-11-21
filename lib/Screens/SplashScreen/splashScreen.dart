import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Authentication/SignIn/sign_in_screen.dart';
import 'dart:async';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 3),
            ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignInScreen()))
    );

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Image.asset("assets/images/Splash_logo.png"),
        ),
      ),
    );
  }
}
