import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_xpense/presentasion/auth/login.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: Color(0xFFF9FBF2),
      body: Center(
        // Add this
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // And this
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Center(
                  child: Text('Trip Xpense',
                      style:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                height: 300,
                child: Center(
                  child: Lottie.asset('assets/lottie/splash.json'),
                ),
              ),
              Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}